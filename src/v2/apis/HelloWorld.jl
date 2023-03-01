"""
    hello_world

return a body contains "message" and "timestamp".

* api: use BUILDKITE_API_INSTANCE
"""
function hello_world(api::BuildKiteAPI = BUILDKITE_API_INSTANCE)
    res = buildkite_get_json(api)
    return res
end
