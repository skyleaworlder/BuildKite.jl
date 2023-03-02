"""
    list_pipelines (need access token)

used to pipelines under specific organization.

curl -H "Authorization: Bearer {your-token}" "https://api.buildkite.com/v2/organizations/{org-slug}/pipelines"

see also https://buildkite.com/docs/apis/rest-api/pipelines#list-pipelines
"""
function list_pipelines(api::BuildKiteAPI, org_slug::String; options...)
    res = buildkite_get_json(api, endpoint = "/v2/organizations/$(org_slug)/pipelines"; options...)
    return res
end

"""
    get_pipeline (need access token)

used to get specific pipeline by organization name and pipeline slug.

* pipeline_slug: used to distinguish pipelines. if a pipeline named "Test for pipeline",
    its slug is "test-for-pipeline".

curl -H "Authorization: Bearer {your-token}" "https://api.buildkite.com/v2/organizations/{org_slug}/pipelines/{pipeline-slug}"

see also https://buildkite.com/docs/apis/rest-api/pipelines#get-a-pipeline
"""
function get_pipeline(api::BuildKiteAPI, org_slug::String, pipeline_slug::String; options...)
    res = buildkite_get_json(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)"; options...)
    return res
end


"""
    create_yaml_pipeline (need access token)

TODO: need tested.

used to create a pipeline with yaml style pipeline definition.

* org_slug: slug of organization.
* name: new pipeline name (not slug).
* repository: the new pipeline belongs to.
* configuration: string of yaml.

```sh
curl -H "Authorization: Bearer {your-token}" -X POST "https://api.buildkite.com/v2/organizations/{org.slug}/pipelines" \
    -d '{
        "name": "My Pipeline X",
        "repository": "git@github.com:acme-inc/my-pipeline.git",
        "configuration": "env:\n \"FOO\": \"bar\"\nsteps:\n - command: \"script/release.sh\"\n   \"name\": \"Build 📦\""
    }'
```

see also https://buildkite.com/docs/apis/rest-api/pipelines#create-a-yaml-pipeline
"""
function create_yaml_pipeline(
    api::BuildKiteAPI, org_slug::String,
    name::String, repository::String, configuration::String; options...)
    options_key = Dict(
        "branch_configuration" => :branch_configuration,
        "cancel_running_branch_builds" => :cancel_running_branch_builds,
        "cancel_running_branch_builds_filter" => :cancel_running_branch_builds_filter,
        "default_branch" => :default_branch,
        "description" => :description,
        "provider_settings" => :provider_settings,
        "skip_queued_branch_builds" => :skip_queued_branch_builds,
        "skip_queued_branch_builds_filter" => :skip_queued_branch_builds_filter,
        "teams" => :teams,
        "visibility" => :visibility
    )
    body = Dict(
        "name" => name,
        "repository" => repository,
        "configuration" => configuration)
    for (str, sym) in options_key
        haskey(options, sym) && (body[str] = options[sym])
    end

    res = buildkite_post_json(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines";
        body = body, options...)
    return res
end


"""
    update_pipeline (need access token)

TODO: need tested.

used to update an existed specific pipeline in organization.

* org_slug: slug of organization, not its name.
* pipeline_slug: slug of pipeline, not its name.

```sh
curl -H "Authorization: Bearer {your-token}" -X PATCH "https://api.buildkite.com/v2/organizations/{org.slug}/pipelines/{slug}" \
  -d '{
    "repository": "git@github.com:acme-inc/new-repo.git",
    "configuration": "steps:\n  - command: \"new.sh\"\n    agents:\n    - \"myqueue=true\""
  }'
```

see also https://buildkite.com/docs/apis/rest-api/pipelines#update-a-pipeline
"""
function update_pipeline(api::BuildKiteAPI, org_slug::String, pipeline_slug::String; options...)
    options_key = Dict(
        "branch_configuration" => :branch_configuration,
        "cancel_running_branch_builds" => :cancel_running_branch_builds,
        "cancel_running_branch_builds_filter" => :cancel_running_branch_builds_filter,
        "configuration" => :configuration,
        "default_branch" => :default_branch,
        "description" => :description,
        "env" => :env,
        "name" => :name,
        "provider_settings" => :provider_settings,
        "repository" => :repository,
        "skip_queued_branch_builds" => :skip_queued_branch_builds,
        "skip_queued_branch_builds_filter" => :skip_queued_branch_builds_filter,
        "visibility" => :visibility
    )
    body = Dict()
    for (str, sym) in options_key
        haskey(options, sym) && (body[str] = options[sym])
    end
    
    res = buildkite_patch_json(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)";
        body = body, options...)
    return res
end


"""
    archive_pipeline (need access token)

used to archive a specific pipeline.

* org_slug: slug of organization, not its name.
* pipeline_slug: slug of pipeline, not its name.

```sh
curl -H "Authorization: Bearer {your-token}" -X POST "https://api.buildkite.com/v2/organizations/{org_slug}/pipelines/{pipeline_slug}/archive"
```

see also https://buildkite.com/docs/apis/rest-api/pipelines#archive-a-pipeline
"""
function archive_pipeline(api::BuildKiteAPI, org_slug::String, pipeline_slug::String; options...)
    res = buildkite_post_json(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)/archive"; options...)
    return res
end


"""
    unarchive_pipeline (need access token)

used to unarchive a specific pipeline.

* org_slug: slug of organization, not its name.
* pipeline_slug: slug of pipeline, not its name.

```sh
curl -H "Authorization: Bearer {your-token}" -X POST "https://api.buildkite.com/v2/organizations/{org.slug}/pipelines/{slug}/unarchive"
```

see also https://buildkite.com/docs/apis/rest-api/pipelines#unarchive-a-pipeline
"""
function unarchive_pipeline(api::BuildKiteAPI, org_slug::String, pipeline_slug::String; options...)
    res = buildkite_post_json(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)/unarchive"; options...)
    return res
end


"""
    delete_pipeline (need access token)

used to delete a specific pipeline. This function only return true when success.
If resp.status doesn't equal 204, throw an error.

* org_slug: slug of organization, not its name.
* pipeline_slug: slug of pipeline, not its name.

```sh
curl -H "Authorization: Bearer {your-token}" -X DELETE "https://api.buildkite.com/v2/organizations/{org_slug}/pipelines/{pipeline_slug}"
```

see also https://buildkite.com/docs/apis/rest-api/pipelines#delete-a-pipeline
"""
function delete_pipeline(api::BuildKiteAPI, org_slug::String, pipeline_slug::String; options...)::Bool
    resp = buildkite_delete(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)"; options...)
    (resp.status == 204) || throw(HTTP.Exceptions.StatusError(
        resp.status, "DELETE", "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)", resp))
end
