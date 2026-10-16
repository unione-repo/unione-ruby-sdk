# Tag

[Back to the list of sections](../README.md)

This family of methods is used to manage user-defined tags. Tags are used to categorize letters based on your own criteria, e. g. to create a distinction between marketing and transactional letters or group together all notifications for a particular order type. UniOne allows you to assign tags to all outgoing emails, and the tags you’ve set may then be used to filter and analyze delivery statistics.

`UniOne::Api::Tag::TagApi`, `client.tag`

| Method | Endpoint | Description |
|---|---|---|
| [`list`](#list) | `POST /tag/list.json` | This method returns the full list of user-defined tags. Does not receive any parameters. |
| [`delete`](#delete) | `POST /tag/delete.json` | Removes tag. |

## list

`POST /tag/list.json` · [Documentation](https://docs.unione.io/en/web-api-ref#tag-list)

This method returns the full list of user-defined tags. Does not receive any parameters.

### Request

The method has no parameters.

### Response: `TagListResponse`

| Field | Type | Description |
|---|---|---|
| `status` | `String` | "success" string (`success`) |
| `tags` | `Array<TagsResponseObject>` | An array of objects containing data for user-defined tags. |

### Example

```ruby
require 'unione'

client = UniOne.client('YOUR_API_KEY')

response = client.tag.list
p response.tags
```

## delete

`POST /tag/delete.json` · [Documentation](https://docs.unione.io/en/web-api-ref#tag-delete)

Removes tag.

### Request: `TagDeleteRequest`

| Field | Type | Required | Description |
|---|---|---|---|
| `tag_id` | `Integer` | yes | Unique tag id. |

### Response: `SuccessResponse`

| Field | Type | Description |
|---|---|---|
| `status` | `String` | "success" string (`success`) |

### Example

```ruby
require 'unione'

Tag = UniOne::Api::Tag::Model

client = UniOne.client('YOUR_API_KEY')

response = client.tag.delete(Tag::TagDeleteRequest.new(
  tag_id: 54
))
p response
```
