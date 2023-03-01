"""
    list_organization

used to get visible organizations list for user.

curl -H "Authorization: Bearer <your-token>" "https://api.buildkite.com/v2/organizations"

```json
[
    {
        "id":"org id",
        "graphql_id":"graphql id",
        "url":"org api url, e.g. https://api.buildkite.com/v2/organizations/<org-name>",
        "web_url":"url to org, e.g. https://buildkite.com/<org-name>",
        "name":"org name",
        "slug":"slug of org",
        "agents_url":"agents api url, e.g. https://api.buildkite.com/v2/organizations/<org-name>/agents",
        "emojis_url":"emoji api url, e.g.https://api.buildkite.com/v2/organizations/<org-name>/emojis",
        "created_at":"2023-02-27T09:06:30.917Z",
        "pipelines_url":"https://api.buildkite.com/v2/organizations/<org-name>/pipelines"
    }
]
```
"""
function list_organization(api::BuildKiteAPI; options...)
    res = buildkite_get_json(api, endpoint = "/v2/organizations"; options...)
    return res
end


"""
    get_organization_by_name

used to get details about specified organization.

curl -H "Authorization: Bearer <your-token>" "https://api.buildkite.com/v2/organizations/<org-name>"

```json
{
    "id":"org id",
    "graphql_id":"graphql id",
    "url":"org api url, e.g. https://api.buildkite.com/v2/organizations/<org-name>",
    "web_url":"url to org, e.g. https://buildkite.com/<org-name>",
    "name":"org name",
    "agents_url":"agents api url, e.g. https://api.buildkite.com/v2/organizations/<org-name>/agents",
    "emojis_url":"emoji api url, e.g.https://api.buildkite.com/v2/organizations/<org-name>/emojis",
    "created_at":"2023-02-27T09:06:30.917Z",
    "pipelines_url":"https://api.buildkite.com/v2/organizations/<org-name>/pipelines"
}
```
"""
function get_organization_by_name(api::BuildKiteAPI, org_name::String; options...)
    res = buildkite_get_json(api, endpoint = "/v2/organizations/$(org_name)"; options...)
    return res
end
