"""
    list_organization (need access token)

used to get visible organizations list for user.

curl -H "Authorization: Bearer {your-token}" "https://api.buildkite.com/v2/organizations"

```json
[
    {
        "id":"org id",
        "graphql_id":"graphql id",
        "url":"org api url, e.g. https://api.buildkite.com/v2/organizations/{org_slug}",
        "web_url":"url to org, e.g. https://buildkite.com/{org_slug}",
        "name":"org name",
        "slug":"slug of org",
        "agents_url":"agents api url, e.g. https://api.buildkite.com/v2/organizations/{org_slug}/agents",
        "emojis_url":"emoji api url, e.g.https://api.buildkite.com/v2/organizations/{org_slug}/emojis",
        "created_at":"2023-02-27T09:06:30.917Z",
        "pipelines_url":"https://api.buildkite.com/v2/organizations/{org_slug}/pipelines"
    }
]
```
"""
function list_organization(api::BuildKiteAPI; options...)
    res = buildkite_get_json(api, endpoint = "/v2/organizations"; options...)
    return res
end


"""
    get_organization_by_name (need access token)

used to get details about specified organization.

curl -H "Authorization: Bearer [your-token]" "https://api.buildkite.com/v2/organizations/[org_slug]"

```json
{
    "id":"org id",
    "graphql_id":"graphql id",
    "url":"org api url, e.g. https://api.buildkite.com/v2/organizations/{org_slug}",
    "web_url":"url to org, e.g. https://buildkite.com/{org_slug}",
    "name":"org name",
    "agents_url":"agents api url, e.g. https://api.buildkite.com/v2/organizations/{org_slug}/agents",
    "emojis_url":"emoji api url, e.g.https://api.buildkite.com/v2/organizations/{org_slug}/emojis",
    "created_at":"2023-02-27T09:06:30.917Z",
    "pipelines_url":"https://api.buildkite.com/v2/organizations/{org_slug}/pipelines"
}
```
"""
function get_organization_by_name(api::BuildKiteAPI, org_slug::String; options...)
    res = buildkite_get_json(api, endpoint = "/v2/organizations/$(org_slug)"; options...)
    return res
end
