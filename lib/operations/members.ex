defmodule Stytch.Members do
  @moduledoc """
  Provides API endpoints related to members
  """

  @default_client Stytch.Client

  @type create_200_json_resp :: %{
          member: Stytch.Member.t(),
          member_id: String.t(),
          organization: Stytch.Organization.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Create a Member
  """
  @spec create(organization_id :: String.t(), body :: map, opts :: keyword) :: {:ok, map} | :error
  def create(organization_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, body: body],
      call: {Stytch.Members, :create},
      url: "/v1/b2b/organizations/#{organization_id}/members",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, {Stytch.Members, :create_200_json_resp}}],
      opts: opts
    })
  end

  @type dangerously_get_200_json_resp :: %{
          member: Stytch.Member.t(),
          member_id: String.t(),
          organization: Stytch.Organization.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Get a Member (Dangerous)
  """
  @spec dangerously_get(member_id :: String.t(), opts :: keyword) :: {:ok, map} | :error
  def dangerously_get(member_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [member_id: member_id],
      call: {Stytch.Members, :dangerously_get},
      url: "/v1/b2b/organizations/members/dangerously_get/#{member_id}",
      method: :get,
      response: [{200, {Stytch.Members, :dangerously_get_200_json_resp}}],
      opts: opts
    })
  end

  @type delete_200_json_resp :: %{
          member_id: String.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Delete a Member
  """
  @spec delete(organization_id :: String.t(), member_id :: String.t(), opts :: keyword) ::
          {:ok, map} | :error
  def delete(organization_id, member_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, member_id: member_id],
      call: {Stytch.Members, :delete},
      url: "/v1/b2b/organizations/#{organization_id}/members/#{member_id}/unlink_retired_email",
      method: :delete,
      response: [{200, {Stytch.Members, :delete_200_json_resp}}],
      opts: opts
    })
  end

  @type delete_mfa_phone_number_200_json_resp :: %{
          member: Stytch.Member.t(),
          member_id: String.t(),
          organization: Stytch.Organization.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Delete Member MFA phone number
  """
  @spec delete_mfa_phone_number(
          organization_id :: String.t(),
          member_id :: String.t(),
          opts :: keyword
        ) :: {:ok, map} | :error
  def delete_mfa_phone_number(organization_id, member_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, member_id: member_id],
      call: {Stytch.Members, :delete_mfa_phone_number},
      url: "/v1/b2b/organizations/#{organization_id}/members/mfa_phone_numbers/#{member_id}",
      method: :delete,
      response: [{200, {Stytch.Members, :delete_mfa_phone_number_200_json_resp}}],
      opts: opts
    })
  end

  @type delete_mfa_totp_200_json_resp :: %{
          member: Stytch.Member.t(),
          member_id: String.t(),
          organization: Stytch.Organization.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Delete Member MFA TOTP
  """
  @spec delete_mfa_totp(organization_id :: String.t(), member_id :: String.t(), opts :: keyword) ::
          {:ok, map} | :error
  def delete_mfa_totp(organization_id, member_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, member_id: member_id],
      call: {Stytch.Members, :delete_mfa_totp},
      url: "/v1/b2b/organizations/#{organization_id}/members/#{member_id}/totp",
      method: :delete,
      response: [{200, {Stytch.Members, :delete_mfa_totp_200_json_resp}}],
      opts: opts
    })
  end

  @type delete_password_200_json_resp :: %{
          member: Stytch.Member.t(),
          member_id: String.t(),
          organization: Stytch.Organization.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Delete Member password
  """
  @spec delete_password(
          organization_id :: String.t(),
          member_password_id :: String.t(),
          opts :: keyword
        ) :: {:ok, map} | :error
  def delete_password(organization_id, member_password_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, member_password_id: member_password_id],
      call: {Stytch.Members, :delete_password},
      url: "/v1/b2b/organizations/#{organization_id}/members/passwords/#{member_password_id}",
      method: :delete,
      response: [{200, {Stytch.Members, :delete_password_200_json_resp}}],
      opts: opts
    })
  end

  @type get_200_json_resp :: %{
          member: Stytch.Member.t(),
          member_id: String.t(),
          organization: Stytch.Organization.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Get a Member

  ## Options

    * `member_id`: Get member by ID

  """
  @spec get(organization_id :: String.t(), opts :: keyword) :: {:ok, map} | :error
  def get(organization_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:member_id])

    client.request(%{
      args: [organization_id: organization_id],
      call: {Stytch.Members, :get},
      url: "/v1/b2b/organizations/#{organization_id}/member",
      method: :get,
      query: query,
      response: [{200, {Stytch.Members, :get_200_json_resp}}],
      opts: opts
    })
  end

  @type reactivate_200_json_resp :: %{
          member: Stytch.Member.t(),
          member_id: String.t(),
          organization: Stytch.Organization.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Reactivate a Member
  """
  @spec reactivate(organization_id :: String.t(), member_id :: String.t(), opts :: keyword) ::
          {:ok, map} | :error
  def reactivate(organization_id, member_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, member_id: member_id],
      call: {Stytch.Members, :reactivate},
      url: "/v1/b2b/organizations/#{organization_id}/members/#{member_id}/reactivate",
      method: :put,
      response: [{200, {Stytch.Members, :reactivate_200_json_resp}}],
      opts: opts
    })
  end

  @type search_200_json_resp_results_metadata :: %{
          next_cursor: String.t() | nil,
          total: integer | nil
        }

  @type search_200_json_resp :: %{
          members: [Stytch.Member.t()],
          organizations: [Stytch.Organization.t()],
          request_id: String.t(),
          results_metadata: Stytch.Members.search_200_json_resp_results_metadata(),
          status_code: integer
        }

  @doc """
  Search for Members
  """
  @spec search(body :: map, opts :: keyword) :: {:ok, map} | :error
  def search(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Members, :search},
      url: "/v1/b2b/organizations/members/search",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, {Stytch.Members, :search_200_json_resp}}],
      opts: opts
    })
  end

  @type unlink_retired_email_200_json_resp :: %{
          member: Stytch.Member.t(),
          member_id: String.t(),
          organization: Stytch.Organization.t(),
          organization_id: String.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Unlink Retired Email
  """
  @spec unlink_retired_email(
          organization_id :: String.t(),
          member_id :: String.t(),
          body :: map,
          opts :: keyword
        ) :: {:ok, map} | :error
  def unlink_retired_email(organization_id, member_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, member_id: member_id, body: body],
      call: {Stytch.Members, :unlink_retired_email},
      url: "/v1/b2b/organizations/#{organization_id}/members/#{member_id}/unlink_retired_email",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, {Stytch.Members, :unlink_retired_email_200_json_resp}}],
      opts: opts
    })
  end

  @type update_200_json_resp :: %{
          member: Stytch.Member.t(),
          member_id: String.t(),
          organization: Stytch.Organization.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Update a Member
  """
  @spec update(
          organization_id :: String.t(),
          member_id :: String.t(),
          body :: map,
          opts :: keyword
        ) :: {:ok, map} | :error
  def update(organization_id, member_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, member_id: member_id, body: body],
      call: {Stytch.Members, :update},
      url: "/v1/b2b/organizations/#{organization_id}/members/#{member_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, {Stytch.Members, :update_200_json_resp}}],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:create_200_json_resp) do
    [
      member: {Stytch.Member, :t},
      member_id: {:string, :generic},
      organization: {Stytch.Organization, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:dangerously_get_200_json_resp) do
    [
      member: {Stytch.Member, :t},
      member_id: {:string, :generic},
      organization: {Stytch.Organization, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:delete_200_json_resp) do
    [member_id: {:string, :generic}, request_id: {:string, :generic}, status_code: :integer]
  end

  def __fields__(:delete_mfa_phone_number_200_json_resp) do
    [
      member: {Stytch.Member, :t},
      member_id: {:string, :generic},
      organization: {Stytch.Organization, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:delete_mfa_totp_200_json_resp) do
    [
      member: {Stytch.Member, :t},
      member_id: {:string, :generic},
      organization: {Stytch.Organization, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:delete_password_200_json_resp) do
    [
      member: {Stytch.Member, :t},
      member_id: {:string, :generic},
      organization: {Stytch.Organization, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:get_200_json_resp) do
    [
      member: {Stytch.Member, :t},
      member_id: {:string, :generic},
      organization: {Stytch.Organization, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:reactivate_200_json_resp) do
    [
      member: {Stytch.Member, :t},
      member_id: {:string, :generic},
      organization: {Stytch.Organization, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:search_200_json_resp) do
    [
      members: [{Stytch.Member, :t}],
      organizations: [{Stytch.Organization, :t}],
      request_id: {:string, :generic},
      results_metadata: {Stytch.Members, :search_200_json_resp_results_metadata},
      status_code: :integer
    ]
  end

  def __fields__(:search_200_json_resp_results_metadata) do
    [next_cursor: {:string, :generic}, total: :integer]
  end

  def __fields__(:unlink_retired_email_200_json_resp) do
    [
      member: {Stytch.Member, :t},
      member_id: {:string, :generic},
      organization: {Stytch.Organization, :t},
      organization_id: {:string, :generic},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:update_200_json_resp) do
    [
      member: {Stytch.Member, :t},
      member_id: {:string, :generic},
      organization: {Stytch.Organization, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end
end
