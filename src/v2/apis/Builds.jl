"""
    list_all_builds (need access token)

used to retrieve all the visible builds.

```sh
curl "https://api.buildkite.com/v2/builds"
```

see also https://buildkite.com/docs/apis/rest-api/builds#list-all-builds
"""
function list_all_builds(api::BuildKiteAPI; query = Dict{String,String}(), options...)
    res = buildkite_get_json(
        api, endpoint = "/v2/builds";
        query = query, options...)
    return res
end


"""
    list_builds_of_organization

used to retrieve all the visible builds under specific organization.

```sh
curl "https://api.buildkite.com/v2/organizations/{org_slug}/builds"
```

see also https://buildkite.com/docs/apis/rest-api/builds#list-builds-for-an-organization
"""
function list_builds_of_organization(api::BuildKiteAPI, org_slug::String; query = Dict{String,String}(), options...)
    res = buildkite_get_json(
        api, endpoint = "/v2/organizations/$(org_slug)/builds";
        query = query, options...)
    return res
end


"""
    list_builds_of_pipeline

used to retrieve all the visible builds under specific pipeline.

```sh
curl "https://api.buildkite.com/v2/organizations/{org_slug}/pipelines/{pipeline_slug}/builds"
```

see also https://buildkite.com/docs/apis/rest-api/builds#list-builds-for-a-pipeline
"""
function list_builds_of_pipeline(
    api::BuildKiteAPI, org_slug::String, pipeline_slug::String;
    query = Dict{String,String}(), options...)
    res = buildkite_get_json(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)/builds";
        query = query, options...)
    return res
end


"""
    get_build

used to retrieve single build from pipeline.

```sh
curl "https://api.buildkite.com/v2/organizations/{org_slug}/pipelines/{pipeline_slug}/builds/{build_number}"
```

see also https://buildkite.com/docs/apis/rest-api/builds#get-a-build
"""
function get_build(
    api::BuildKiteAPI, org_slug::String, pipeline_slug::String, build_number::Integer;
    query = Dict{String,String}(), options...)
    res = buildkite_get_json(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)/builds/$(build_number)";
        query = query, options...)
    return res
end


"""
    create_build

TODO: need tested.

used to create a build using a specific pipeline under the given organization.

```sh
curl -X POST "https://api.buildkite.com/v2/organizations/{org_slug}/pipelines/{pipeline_slug}/builds" \
  -d '{
    "commit": "abcd0b72a1e580e90712cdd9eb26d3fb41cd09c8",
    "branch": "master",
    "author": {
      "name": "Keith Pitt",
      "email": "me@keithpitt.com"
    },
    "message": "Testing all the things :rocket:",
    "env": {
      "MY_ENV_VAR": "some_value"
    },
    "meta_data": {
      "some build data": "value",
      "other build data": true
    }
  }'```

see also https://buildkite.com/docs/apis/rest-api/builds#create-a-build
"""
function create_build(
    api::BuildKiteAPI, org_slug::String, pipeline_slug::String,
    commit::String, branch::String, author::Dict{String,String};
    clean_checkout = false, env = Dict(), ignore_pipeline_branch_filters = false,
    meta_data = Dict(), options...)
    options_key = Dict(
        "message" => :message,
        "pull_request_base_branch" => :pull_request_base_branch,
        "pull_request_id" => :pull_request_id,
        "pull_request_repository" => :pull_request_repository)
    body = Dict(
        "author" => author,
        "clean_checkout" => clean_checkout,
        "env" => env,
        "ignore_pipeline_branch_filters" => ignore_pipeline_branch_filters,
        "meta_data" => meta_data)
    for (str, sym) in options_key
        haskey(options, sym) && (body[str] = options[sym])
    end

    res = buildkite_post_json(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)/builds";
        body = body, options...)
    return res
end


"""
    cancel_build

used to cancel a pipeline build.

```sh
curl -X PUT "https://api.buildkite.com/v2/organizations/{org_slug}/pipelines/{pipeline_slug}/builds/{build_number}/cancel"
```

see also https://buildkite.com/docs/apis/rest-api/builds#cancel-a-build
"""
function cancel_build(api::BuildKiteAPI, org_slug::String, pipeline_slug::String, build_number::Integer; options...)
    res = buildkite_put_json(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)/builds/$(build_number)/cancel"; options...)
    return res
end


"""
    rebuild_build

used to rebuild a specific "build".

```sh
curl -X PUT "https://api.buildkite.com/v2/organizations/{org_slug}/pipelines/{pipeline_slug}/builds/{build_number}/rebuild"
```

see also https://buildkite.com/docs/apis/rest-api/builds#rebuild-a-build
"""
function rebuild_build(api::BuildKiteAPI, org_slug::String, pipeline_slug::String, build_number::Integer; options...)
    res = buildkite_put_json(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)/builds/$(build_number)/rebuild"; options...)
    return res
end
