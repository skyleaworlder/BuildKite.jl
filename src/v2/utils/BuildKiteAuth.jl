abstract type BuildKiteAuth end


"""
    DummyAuth

Just used as default k-v argument.
"""
struct DummyAuth <: BuildKiteAuth end


"""
    AccessTokenAuth

Tokens can be used to authenticate with the REST and GraphQL APIs.
Created at https://buildkite.com/user/api-access-tokens
"""
struct AccessTokenAuth <: BuildKiteAuth
    AT::String
end


"""
    append_auth_info!

* headers: HTTP request header.
* auth_info: here is AccessTokenAuth, a wrapper of String (API Access Token).

e.g. the following command would return visible org list:

curl -H "Authorization: Bearer <your-token>" "https://api.buildkite.com/v2/organizations"
"""
function append_auth_info!(headers, auth_info::DummyAuth) end
function append_auth_info!(headers, auth_info::AccessTokenAuth)
    headers["Authorization"] = "Bearer $(auth_info.AT)"
end
