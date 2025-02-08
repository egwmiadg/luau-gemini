local enums = require(script.Parent.enums)

export type UsageMetadata = {
	candidatesTokenCount: number,
	promptTokenCount: number,
	totalTokenCount: number
}

export type AISafetyRating = {
	category: enums.HarmCategory,
	probability: string,
}

export type HttpResponse = {
	Body: string | {},
	Headers: { [string]: string },
	StatusCode: number,
	StatusMessage: string,
	Success: boolean
}

export type QueryParam = {
	name: string,
	value: any?
}

export type FetchOptions = {
	url: string,
	strict: boolean?,
	data: string | {}?,
	query: {QueryParam}?,
	headers: {[string]: string}?
}

export type Candidate = {
	avgLogprobs: number,
	content: Content,
	finishReason: enums.finishReason,
	safetyRatings: { AISafetyRating },
	
}

export type Schema = {
	type: enums.Type,
	format: string?,
	description: string?,
	nullable: boolean?,
	enum: {string}?,
	maxItems: number?,
	minItems: number?,
	properties: {[string]: Schema}?,
	required: {string}?,
	items: Schema?
}

export type FunctionDeclaration = {
	name: string,
	description: string?,
	paramaters: Schema?
}

export type DynamicRetrievalConfig = {
	mode: enums.Mode,
	dynamicThreshold: number
}

export type GoogleSearchRetrieval = {
	dynamicRetrievalConfig: DynamicRetrievalConfig
}

export type Tool = {
	functionDeclarations: {FunctionDeclaration}?,
	googleSearchRetrieval: GoogleSearchRetrieval?
}

export type FieldViolation = {
	field: string,
	description: string
}

export type ErrorDetail = {
	["@type"]: string,
	fieldViolations: {FieldViolation}
}

export type Error = {
	code: number,
	message: string,
	status: string?,
	details: {ErrorDetail}?
}

export type Response = {
	candidates: {
		Candidate
	},
	modelVersion: Model,
	usageMetadata: UsageMetadata,
	error: Error
}

export type Request = {
	contents: {Content}?,
	tools: Tool?,
	systemInstructions: (string | Part | Content)?
} & BaseParams

export type RequestOptions = {
	-- Version of API endpoint to call (e.g. "v1" or "v1beta"). If not specified,
	-- defaults to latest stable version.
	apiVersion: string?,
	-- Base endpoint url. Defaults to "https://generativelanguage.googleapis.com"
	baseUrl: string?,
	-- Custom HTTP request headers.
	customHeaders: {[string]: string}
}

export type Result = {
	response: {
		text: () -> (string),
		functionCalls: () -> ({FunctionCall}?),
		filteredText: () -> (string)
	},
	body: Response
}

export type GenerationConfig = {
	candidateCount: number?,
	stopSequences: string?,
	maxOutputTokens: number?,
	temperature: number?,
	topP: number?,
	topK: number?
}

export type BaseParams = {
	safetySettings: {AISafetyRating}?,
	generationConfig: GenerationConfig?
}

export type StartChatParams = {
	history: {Content}?,
	tools: Tool?,
	systemInstruction: (string | Part | Content)?
} & BaseParams

export type Chat = {
	getHistory: () -> {Content},
	sendMessage: (request: string | {Part}) -> Result
}

export type Model = {
	generateContent: (prompt: (Request | string)) -> Result,
	startChat: (startChatParams: StartChatParams?) -> Chat
}

export type ModelParams = {
	model: enums.Model,
	tools: Tool?,
	systemInstruction: (string | Part | Content)?,
} & BaseParams

export type CodeExecutionResult = {
	outcome: enums.Outcome,
	output: string
}

export type ExecutableCode = {
	language: enums.Language,
	code: string
}

export type FunctionResponse = {
	name: string,
	response: { any }
}

export type FunctionCall = {
	name: string,
	args: { any }
}

export type Blob = {
	mimeType: string,
	data: string
}

export type Part = {
	text: string?,
	inlineData: Blob?,
	functionCall: FunctionCall?,
	functionResponse: FunctionResponse?,
	executableCode: ExecutableCode?,
	codeExecutionResult: CodeExecutionResult?
}

export type Content = {
	role: ("user" | "model" | "function" | string)?,
	parts: { Part }
}

return {}
