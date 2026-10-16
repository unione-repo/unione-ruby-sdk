# ConfirmedEmail

[Back to the list of sections](../README.md)

Manage email addresses confirmed for sandbox-domain sending. These methods are available only with a main account API key.

`UniOne::Api::ConfirmedEmail::ConfirmedEmailApi`, `client.confirmed_email`

| Method | Endpoint | Description |
|---|---|---|
| [`create`](#create) | `POST /confirmed-email/create.json` | Adds an email address and sends a confirmation link. |
| [`list`](#list) | `POST /confirmed-email/list.json` | Lists confirmed and unconfirmed email addresses for the account. |
| [`delete`](#delete) | `POST /confirmed-email/delete.json` | Deletes an email address from the account's confirmed email list. |

## create

`POST /confirmed-email/create.json` · [Documentation](https://docs.unione.io/en/web-api-ref#confirmed-email-create)

Adds an email address and sends a confirmation link.

### Request: `ConfirmedEmailRequest`

| Field | Type | Required | Description |
|---|---|---|---|
| `email` | `String` | yes | Email address to add or delete. |

### Response: `ConfirmedEmailCreateResponse`

| Field | Type | Description |
|---|---|---|
| `status` | `String` | "success" string (`success`) |
| `confirmed_email` | `ConfirmedEmail` |  |

### Example

```ruby
require 'unione'

ConfirmedEmail = UniOne::Api::ConfirmedEmail::Model

client = UniOne.client('YOUR_API_KEY')

response = client.confirmed_email.create(ConfirmedEmail::ConfirmedEmailRequest.new(
  email: 'dev@example.com'
))
p response.confirmed_email
```

## list

`POST /confirmed-email/list.json` · [Documentation](https://docs.unione.io/en/web-api-ref#confirmed-email-list)

Lists confirmed and unconfirmed email addresses for the account.

### Request

The method has no parameters.

### Response: `ConfirmedEmailListResponse`

| Field | Type | Description |
|---|---|---|
| `status` | `String` | "success" string (`success`) |
| `confirmed_emails` | `Array<ConfirmedEmail>` |  |

### Example

```ruby
require 'unione'

client = UniOne.client('YOUR_API_KEY')

response = client.confirmed_email.list
p response.confirmed_emails
```

## delete

`POST /confirmed-email/delete.json` · [Documentation](https://docs.unione.io/en/web-api-ref#confirmed-email-delete)

Deletes an email address from the account's confirmed email list.

### Request: `ConfirmedEmailRequest`

| Field | Type | Required | Description |
|---|---|---|---|
| `email` | `String` | yes | Email address to add or delete. |

### Response: `ConfirmedEmailDeleteResponse`

| Field | Type | Description |
|---|---|---|
| `status` | `String` | "success" string (`success`) |
| `message` | `String` |  |

### Example

```ruby
require 'unione'

ConfirmedEmail = UniOne::Api::ConfirmedEmail::Model

client = UniOne.client('YOUR_API_KEY')

response = client.confirmed_email.delete(ConfirmedEmail::ConfirmedEmailRequest.new(
  email: 'dev@example.com'
))
p response.message
```
