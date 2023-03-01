using URIs
import HTTP
import JSON

"""
BuildKiteAPI is an abstract interface used to communicate with BuildKite REST API
"""
abstract type BuildKiteAPI end


struct BuildKiteAPIV2 <: BuildKiteAPI
    api_server::URI
end


const BUILDKITE_API_INSTANCE = BuildKiteAPIV2(URI("https://api.buildkite.com"))


"""
    concat_resource_path_template

* endpoint: e.g. /organizations/\$(your_org)/pipelines/\$(your_pipeline)/builds
"""
concat_resource_path_template(endpoint::String) =
    URI(BUILDKITE_API_INSTANCE.api_server, path = endpoint)
concat_resource_path_template(api::BuildKiteAPIV2, endpoint::String) =
    URI(api.api_server, path = endpoint)


"""
    buildkite_common_request

* api: normally BuildKiteAPIV2.
* http_method: HTTP.get, HTTP.post, HTTP.put or HTTP.delete.
* endpoint: REST-ful API endpoint.

* query: http url query.
* header: http header.
* body: http body, always application/json in REST-ful API, here use Dict.
"""
function buildkite_common_request(
        api::BuildKiteAPI, http_method, endpoint::String;
        query = Dict{String,String}(),
        auth_info = DummyAuth(), headers = Dict{String,String}(),
        body = Dict()
    )
    append_auth_info!(headers, auth_info)
    resource_path = concat_resource_path_template(api, endpoint)
    print(headers, auth_info)
    if http_method == HTTP.get
        req = HTTP.get(URI(resource_path, query = query), headers)
    else
        req = http_method(resource_path, headers, JSON.json(body))
    end
    return req
end


buildkite_get(api::BuildKiteAPI; endpoint = "", options...) = buildkite_common_request(api, HTTP.get, endpoint; options...)
buildkite_post(api::BuildKiteAPI; endpoint = "", options...) = buildkite_common_request(api, HTTP.post, endpoint; options...)
buildkite_put(api::BuildKiteAPI; endpoint = "", options...) = buildkite_common_request(api, HTTP.put, endpoint; options...)
buildkite_delete(api::BuildKiteAPI; endpoint = "", options...) = buildkite_common_request(api, HTTP.delete, endpoint; options...)

get_respoonse_body_in_json(req::HTTP.Message) = JSON.parse(HTTP.payload(req, String))

buildkite_get_json(api::BuildKiteAPI; endpoint = "", options...) = get_respoonse_body_in_json(buildkite_get(api; endpoint, options...))
buildkite_post_json(api::BuildKiteAPI; endpoint = "", options...) = get_respoonse_body_in_json(buildkite_post(api; endpoint, options...))
buildkite_put_json(api::BuildKiteAPI; endpoint = "", options...) = get_respoonse_body_in_json(buildkite_put(api; endpoint, options...))
buildkite_delete_json(api::BuildKiteAPI; endpoint = "", options...) = get_respoonse_body_in_json(buildkite_delete(api; endpoint, options...))
