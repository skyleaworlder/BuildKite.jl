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

include("apis/Pipelines.jl")
export list_pipelines, get_pipeline,
    create_yaml_pipeline, update_pipeline, delete_pipeline,
    archive_pipeline, unarchive_pipeline

include("apis/Builds.jl")
export list_all_builds, list_builds_of_organization, list_all_builds,
    get_build, create_build, cancel_build, rebuild_build

include("apis/Jobs.jl")
export retry_job, unblock_job, get_job_env
    get_job_log_output, delete_job_log_output

end # module v2