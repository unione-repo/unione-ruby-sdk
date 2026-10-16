# System

[Back to the list of sections](../README.md)

System operations.

`UniOne::Api::System::SystemApi`, `client.system`

| Method | Endpoint | Description |
|---|---|---|
| [`ping`](#ping) | `POST /system/ping.json` | Checks API key validity and returns user ID. |
| [`info`](#info) | `POST /system/info.json` | Gets user or project info by API key. |

## ping

`POST /system/ping.json` · [Documentation](https://docs.unione.io/en/web-api-ref#system-ping)

Checks API key validity and returns user ID.

### Request

The method has no parameters.

### Response: `SystemPingResponse`

| Field | Type | Description |
|---|---|---|
| `status` | `String` | "success" string (`success`) |
| `user_id` | `Integer` | Unique user identifier. |

### Example

```ruby
require 'unione'

client = UniOne.client('YOUR_API_KEY')

response = client.system.ping
p response.user_id
```

## info

`POST /system/info.json` · [Documentation](https://docs.unione.io/en/web-api-ref#system-info)

Gets user or project info by API key.

### Request

The method has no parameters.

### Response: `SystemInfoResponse`

| Field | Type | Description |
|---|---|---|
| `status` | `String` | "success" string (`success`) |
| `user_id` | `Integer` | Unique user identifier. |
| `email` | `String` | Email of the user. |
| `project_id` | `String` | Unqiue project identifier, ASCII string up to 36 characters long. Present only if the API key used for request is the project API key. |
| `project_name` | `String` | Project name, unique for user account. Present only if the API key used for request is the project API key. |
| `project_accounting` | `ProjectAccountingObject` | Object with email counter properties. Present only if the API key used for request is the user API key. |
| `accounting` | `SystemInfoResponseAccounting` | Object with accounting period properties. Present only if the API key used for request is the user API key. |

### Example

```ruby
require 'unione'

client = UniOne.client('YOUR_API_KEY')

response = client.system.info
p response.user_id
```
