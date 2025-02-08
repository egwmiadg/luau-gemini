--!strict

local http = game:GetService('HttpService')
local textService = game:GetService('TextService')

local types = require(script.Parent.types)
local enums = require(script.Parent.enums)
local lib = {}

local function getFunctionCalls(response: types.Response): {types.FunctionCall}?
	local functionCalls = {}

	if response.candidates and response.candidates[1] and response.candidates[1].content and response.candidates[1].content.parts then
		for _, part in pairs(response.candidates[1].content.parts) do
			if part.functionCall then
				table.insert(functionCalls, part.functionCall)
			end
		end
	end
	
	if #functionCalls > 0 then
		return functionCalls
	else
		return nil
	end
end

local function getText(response: types.Response)
	local textStrings = {}

	if response.candidates and response.candidates[1] and response.candidates[1].content and response.candidates[1].content.parts then
		for _, part in ipairs(response.candidates[1].content.parts) do
			if part.text then
				table.insert(textStrings, part.text)
			end
			if part.executableCode then
				table.insert(
					textStrings,
					"\n```" ..
						part.executableCode.language ..
						"\n" ..
						part.executableCode.code ..
						"\n```\n"
				)
			end
			if part.codeExecutionResult then
				table.insert(
					textStrings,
					"\n```\n" .. part.codeExecutionResult.output .. "\n```\n"
				)
			end
		end
	end

	if #textStrings > 0 then
		return lib.trim(table.concat(textStrings, ""))
	else
		return ""
	end
end

function lib.newError(...:string)
	return `[Gem Error] {table.concat({...}, " ")}`
end

function lib.trim(s: string)
	return s:match("^%s*(.-)%s*$") or ""
end

function lib.startsWith(str: string, query: string): boolean
	return str:sub(1, #query) == query
end

function lib.fromResult(response: types.Response): types.Result
	local result = {}
	local resResponse = {}
	
	local filteredText
	
	if (response.error) then
		local errorMessage = response.error
		local message = `[{errorMessage.status or errorMessage.code}] {errorMessage.message}`
		
		error(message, 2)
	end
	
	function resResponse.text()
		return getText(response)
	end
	
	function resResponse.filteredText(userid: number?)
		if (not filteredText) then
			if (not userid) then
				error(lib.newError("An UserId is required when you first run filteredText()"), 2)
			end
			filteredText = textService:FilterStringAsync(resResponse.text(), userid):GetNonChatStringForBroadcastAsync()
		end
		
		return filteredText
	end
	
	function resResponse.functionCalls()
		return getFunctionCalls(response)
	end
	
	result.response = resResponse
	result.body = response
	
	return result
end

function lib.fetch(method: enums.httpMethod, opts: types.FetchOptions): types.HttpResponse
	local data: string? = opts.data and ((typeof(opts.data) == "table" and http:JSONEncode(opts.data):gsub("%[%]", "{}")) or opts.data)
	local strictCall: (string) -> () = opts.strict == true and error or warn
	
	if (data and (method == "get" or method == "head")) then
		strictCall(`Cannot {method} with an body.`)
		data = nil
	end
	
	if (opts.query) then
		local queryString = "?"
		for i,v in pairs(opts.query) do
			local text = `{v.name}` .. (v.value and `={v.value}`) or ""
			if (i==1) then
				queryString ..= text
			else
				queryString ..= text
			end
		end
		opts.url ..= queryString
	end
	
	local request = {
		Url = opts.url,
		Body = data,
		Method = string.upper(method),
		Headers = opts.headers
	}
	
	local response = http:RequestAsync(request)
	
	if (lib.startsWith(response.Headers["content-type"], "application/json")) then
		response.Body = http:JSONDecode(response.Body)
	end
	
	return response, request
end

return lib
