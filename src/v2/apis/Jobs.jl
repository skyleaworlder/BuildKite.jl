"""
    retry_job

TODO: need tested

used to retry a failed or timeout job. You can only retry each job_id once.
To retry a "second time" use the new job_id returned in the first retry query.

```sh
curl -X PUT "https://api.buildkite.com/v2/organizations/{org_slug}/pipelines/{pipeline_slug}/builds/{build_number}/jobs/{job_id}/retry"
```

see also https://buildkite.com/docs/apis/rest-api/jobs#retry-a-job
"""
function retry_job(
    api::BuildKiteAPI, org_slug::String, pipeline_slug::String,
    build_number::Integer, job_id::Integer; options...)
    res = buildkite_put_json(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)/builds/$(build_number)/jobs/$(job_id)/retry"; options...)
    return res
end


"""
    unblock_job

TODO: need tested

used to unblock a job.

```sh
curl -X PUT "https://api.buildkite.com/v2/organizations/{org_slug}/pipelines/{pipeline_slug}/builds/{build_number}/jobs/{job_id}/unblock"  \
  -d '{
    "fields": {
      "name": "Liam Neeson",
      "email": "liam@evilbatmanvillans.com"
    }
  }'
```

see also https://buildkite.com/docs/apis/rest-api/jobs#unblock-a-job
"""
function unblock_job(
    api::BuildKiteAPI, org_slug::String, pipeline_slug::String,
    build_number::Integer, job_id::Integer; options...)
    res = buildkite_put_json(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)/builds/$(build_number)/jobs/$(job_id)/unblock"; options...)
    return res
end


"""
    get_job_log_output

TODO: need tested

used to get log output of a specific job.

```sh
curl "https://api.buildkite.com/v2/organizations/{org_slug}/pipelines/{pipeline_slug}/builds/{build_number}/jobs/{job_id}/log" \
    -d '{
        "url": "https://api.buildkite.com/v2/organizations/my-great-org/pipelines/my-pipeline/builds/1/jobs/b63254c0-3271-4a98-8270-7cfbd6c2f14e/log",
        "content": "This is the job's log output",
        "size": 28,
        "header_times": [1563337899810051000,1563337899811015000,1563337905336878000,1563337906589603000,156333791038291900]
      }'
```

see also https://buildkite.com/docs/apis/rest-api/jobs#get-a-jobs-log-output
"""
function get_job_log_output(
    api::BuildKiteAPI, org_slug::String, pipeline_slug::String,
    build_number::Integer, job_id::Integer; options...)
    res = buildkite_get_json(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)/builds/$(build_number)/jobs/$(job_id)/log"; options...)
    return res
end


"""
    delete_job_log_output

TODO: need tested

used to delete log output of a specific job.

```sh
curl -X DELETE "https://api.buildkite.com/v2/organizations/{org_slug}/pipelines/{pipeline_slug}/builds/{build_number}/jobs/{job_id}/log"
```

see also https://buildkite.com/docs/apis/rest-api/jobs#delete-a-jobs-log-output
"""
function delete_job_log_output(
    api::BuildKiteAPI, org_slug::String, pipeline_slug::String,
    build_number::Integer, job_id::Integer; options...)
    res = buildkite_delete_json(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)/builds/$(build_number)/jobs/$(job_id)/log"; options...)
    return res
end


"""
    get_job_env

TODO: need tested

used to get environment variables of a specific job.

```sh
curl "https://api.buildkite.com/v2/organizations/{org.slug}/pipelines/{pipeline_slug}/builds/{build_number}/jobs/{job_id}/env"
```

see also https://buildkite.com/docs/apis/rest-api/jobs#get-a-jobs-environment-variables
"""
function get_job_env(
    api::BuildKiteAPI, org_slug::String, pipeline_slug::String,
    build_number::Integer, job_id::Integer; options...)
    res = buildkite_get_json(
        api, endpoint = "/v2/organizations/$(org_slug)/pipelines/$(pipeline_slug)/builds/$(build_number)/jobs/$(job_id)/env"; options...)
    return res
end
