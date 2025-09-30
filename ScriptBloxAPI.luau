local HttpService = game:GetService("HttpService")

local BASE_URL = "https://scriptblox.com/api/script/"

local ScriptBloxAPI = {}

local function request(url: string)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)

    if not success then
        warn("Request failed: " .. tostring(result))
        return nil
    end

    local ok, data = pcall(function()
        return HttpService:JSONDecode(result)
    end)

    if not ok then
        warn("JSON decode failed: " .. tostring(data))
        return nil
    end

    return data
end

function ScriptBloxAPI.fetch(params: {[string]: any}?): any
    params = params or {}
    local query = {}

    for key, value in pairs(params) do
        table.insert(query, key .. "=" .. HttpService:UrlEncode(tostring(value)))
    end

    local url = BASE_URL .. "fetch"
    if #query > 0 then
        url = url .. "?" .. table.concat(query, "&")
    end

    return request(url)
end

function ScriptBloxAPI.search(query: string, params: {[string]: any}?): any
    params = params or {}
    params.q = query

    local queryParts = {}
    for key, value in pairs(params) do
        table.insert(queryParts, key .. "=" .. HttpService:UrlEncode(tostring(value)))
    end

    local url = BASE_URL .. "search?" .. table.concat(queryParts, "&")
    return request(url)
end

function ScriptBloxAPI.getDetails(scriptId: string): any
    local url = BASE_URL .. scriptId
    return request(url)
end

function ScriptBloxAPI.getRaw(scriptId: string): any
    local url = BASE_URL .. "raw/" .. scriptId
    return request(url)
end

function ScriptBloxAPI.trending(): any
    local url = BASE_URL .. "trending"
    return request(url)
end

return ScriptBloxAPI
