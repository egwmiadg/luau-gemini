--!strict

local types = require(script.types)
local enums = require(script.enums)
local lib = require(script.lib)

local function gem(token: string)
	local gem = {}

	local headers = {
		["content-type"] = "application/json"
	}
	
	local tokenQuery: types.QueryParam = {
		name = "key",
		value = token
	}
	
	function gem.getGenerativeModel(opts: types.ModelParams, requestOptions: types.RequestOptions?): types.Model
		if (not opts or not opts.model) then
			error(lib.newError("Must provide a model name"), 2)
		end
		
		local baseUrl = requestOptions and requestOptions.baseUrl or enums.Host
		local version = requestOptions and requestOptions.apiVersion or enums.Version
		
		local model = {} :: types.Model
		local modelHost = `https://{baseUrl}/{version}/models/{opts.model}`
		local genContent = `{modelHost}:generateContent`
		
		function model.generateContent(prompt)
			local promptData = {
				contents = typeof(prompt) == "table" and prompt.contents or {
					{
						parts = {
							{
								role = "user",
								text = prompt
							}
						}
					}
				},
				system_instruction = typeof(prompt) == "table" and prompt.systemInstructions and {
					parts = {
						{text = prompt.systemInstructions}
					}
				},
				tools = typeof(prompt) == "table" and prompt.tools
			}
			
			local res = lib.fetch("post", {
				url = genContent,
				query = {tokenQuery},
				data = promptData,
				headers = headers
			})
			
			return lib.fromResult(res.Body :: types.Response)
		end
		
		function model.startChat(startChatParams): types.Chat
			local chat = {} :: types.Chat
			local history: {types.Content} = startChatParams and startChatParams.history or {}
			
			local function sendMessage(prompt: {types.Part})
				table.insert(history, {
					parts = prompt,
					role = "user"
				})
				
				local result = model.generateContent({
					contents = history,
					systemInstructions = startChatParams and startChatParams.systemInstruction or opts.systemInstruction,
					tools = startChatParams and startChatParams.tools or opts.tools
				})
				
				local candidate = result.body.candidates[1]
				
				if (not candidate.content) then
					error(lib.newError(`Candidate was blocked due to {candidate.finishReason}`), 2)
				end
				
				table.insert(history, {
					role = "model",
					parts = candidate.content.parts
				})
				
				return result
			end
			
			function chat.getHistory()
				return history
			end
			
			function chat.sendMessage(prompt)
				local newPrompt
				
				if (typeof(prompt) == "table") then
					newPrompt = prompt
				else
					newPrompt = {
						{
							text = prompt,
						}
					}
				end
				
				return sendMessage(newPrompt)
			end
			
			return chat
		end
		
		return model
	end

	return gem
end

return gem
