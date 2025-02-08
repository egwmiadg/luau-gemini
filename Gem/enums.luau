local enum = {}

export type finishReason = 
	"OTHER" |
"SAFETY" | 
"MALFORMED_FUNCTION_CALL" | 
"SPII" | 
"PROHIBITED_CONTENT" | 
"BLOCKLIST" |
"LANGUAGE" |
"RECITATION" |
"MAX_TOKENS" |
"STOP" |
"FINISH_REASON_UNSPECIFIED"
export type httpMethod = 
	"get"
|"post"
|"patch"
|"put"
|"delete"
|"head"
|"options"
|"patch"
|"trace"
export type Model = 
	"chat-bison-001"
|"text-bison-001"
|"embedding-gecko-001"
|"gemini-1.0-pro-latest"
|"gemini-1.0-pro"
|"gemini-pro"
|"gemini-1.0-pro-001"
|"gemini-1.0-pro-vision-latest"
|"gemini-pro-vision"
|"gemini-1.5-pro-latest"
|"gemini-1.5-pro-001"
|"gemini-1.5-pro-002"
|"gemini-1.5-pro"
|"gemini-1.5-pro-exp-0801"
|"gemini-1.5-pro-exp-0827"
|"gemini-1.5-flash-latest"
|"gemini-1.5-flash-001"
|"gemini-1.5-flash-001-tuning"
|"gemini-1.5-flash"
|"gemini-1.5-flash-exp-0827"
|"gemini-1.5-flash-002"
|"gemini-1.5-flash-8b"
|"gemini-1.5-flash-8b-001"
|"gemini-1.5-flash-8b-latest"
|"gemini-1.5-flash-8b-exp-0827"
|"gemini-1.5-flash-8b-exp-0924"
|"gemini-2.0-flash-exp"
|"gemini-exp-1206"
|"gemini-exp-1121"
|"gemini-exp-1114"
|"learnlm-1.5-pro-experimental"
|"embedding-001"
|"text-embedding-004"
|"aqa"
| string
export type Language = "PYTHON" | "LANGUAGE_UNSPECIFIED"
export type Outcome = 
	"OUTCOME_UNSPECIFIED" 
| "OUTCOME_OK" 
| "OUTCOME_FAILED" 
| "OUTCOME_DEADLINE_EXCEEDED"
export type HarmCategory = 
	"HARM_CATEGORY_UNSPECIFIED"
|"HARM_CATEGORY_HATE_SPEECH" 
|"HARM_CATEGORY_SEXUALLY_EXPLICIT" 
|"HARM_CATEGORY_HARASSMENT"
|"HARM_CATEGORY_DANGEROUS_CONTENT"
export type HarmThreshold = 
	"HARM_BLOCK_THRESHOLD_UNSPECIFIED"
|"BLOCK_LOW_AND_ABOVE" 
|"BLOCK_MEDIUM_AND_ABOVE" 
|"BLOCK_ONLY_HIGH"
|"BLOCK_NONE"
export type Type = 
	"TYPE_UNSPECIFIED"
|"STRING"
|"NUMBER"
|"INTEGER"
|"BOOLEAN"
|"ARRAY"
|"OBJECT"
export type Mode = "MODE_UNSPECIFIED" | "MODE_DYNAMIC"

enum.Host = "generativelanguage.googleapis.com"

enum.Version = "v1beta"

enum.Mode = {
	MODE_UNSPECIFIED = "MODE_UNSPECIFIED",
	MODE_DYNAMIC = "MODE_DYNAMIC",
}

enum.Type = {
	TYPE_UNSPECIFIED = "TYPE_UNSPECIFIED",
	STRING = "STRING",
	NUMBER = "NUMBER",
	INTEGER = "INTEGER",
	BOOLEAN = "BOOLEAN",
	ARRAY = "ARRAY",
	OBJECT = "OBJECT",
}

enum.HarmCategory = {
	HARM_CATEGORY_UNSPECIFIED = "HARM_CATEGORY_UNSPECIFIED",

	HARM_CATEGORY_HATE_SPEECH = "HARM_CATEGORY_HATE_SPEECH",

	HARM_CATEGORY_SEXUALLY_EXPLICIT = "HARM_CATEGORY_SEXUALLY_EXPLICIT",

	HARM_CATEGORY_HARASSMENT = "HARM_CATEGORY_HARASSMENT",

	HARM_CATEGORY_DANGEROUS_CONTENT = "HARM_CATEGORY_DANGEROUS_CONTENT",
}

enum.HarmBlockThreshold = {
	HARM_BLOCK_THRESHOLD_UNSPECIFIED = "HARM_BLOCK_THRESHOLD_UNSPECIFIED",

	BLOCK_LOW_AND_ABOVE = "BLOCK_LOW_AND_ABOVE",

	BLOCK_MEDIUM_AND_ABOVE = "BLOCK_MEDIUM_AND_ABOVE",

	BLOCK_ONLY_HIGH = "BLOCK_ONLY_HIGH",

	BLOCK_NONE = "BLOCK_NONE",
}

return enum
