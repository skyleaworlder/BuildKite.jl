module v2

version() = "v2"
export version

include("utils/BuildKiteAuth.jl")
export BuildKiteAuth, DummyAuth, AccessTokenAuth,
    append_auth_info!

include("utils/BuildKiteRequest.jl")
export BuildKiteAPI, BuildKiteAPIV2, BUILDKITE_API_INSTANCE,
    buildkite_common_request,
    buildkite_get, buildkite_post, buildkite_put, buildkite_delete,
    buildkite_get_json, buildkite_post_json, buildkite_put_json, buildkite_delete_json

include("apis/HelloWorld.jl")
export hello_world

include("apis/Organizations.jl")
export list_organization, get_organization_by_name

end # module v2