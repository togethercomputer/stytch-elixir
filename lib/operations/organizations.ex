defmodule Stytch.Organizations do
  @moduledoc """
  Provides API endpoints related to organizations
  """

  @default_client Stytch.Client

  @type create_200_json_resp :: %{
          organization: Stytch.Organization.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Create an Organization
  """
  @spec create(body :: map, opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def create(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Organizations, :create},
      url: "/v1/b2b/organizations",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {Stytch.Organizations, :create_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type delete_200_json_resp :: %{
          organization_id: String.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Delete an Organization
  """
  @spec delete(organization_id :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Stytch.Error.t()}
  def delete(organization_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id],
      call: {Stytch.Organizations, :delete},
      url: "/v1/b2b/organizations/#{organization_id}",
      method: :delete,
      response: [
        {200, {Stytch.Organizations, :delete_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type get_200_json_resp :: %{
          organization: Stytch.Organization.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Get an Organization
  """
  @spec get(organization_id :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Stytch.Error.t()}
  def get(organization_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id],
      call: {Stytch.Organizations, :get},
      url: "/v1/b2b/organizations/#{organization_id}",
      method: :get,
      response: [
        {200, {Stytch.Organizations, :get_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type search_200_json_resp :: %{
          organizations: [Stytch.Organization.t()],
          request_id: String.t(),
          results_metadata: Stytch.Organizations.search_200_json_resp_results_metadata(),
          status_code: integer
        }

  @type search_200_json_resp_results_metadata :: %{
          next_cursor: String.t() | nil,
          total: integer | nil
        }

  @doc """
  Search for Organizations
  """
  @spec search(body :: map, opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def search(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Organizations, :search},
      url: "/v1/b2b/organizations/search",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {Stytch.Organizations, :search_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type update_200_json_resp :: %{
          organization: Stytch.Organization.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Update an Organization
  """
  @spec update(organization_id :: String.t(), body :: map, opts :: keyword) ::
          {:ok, map} | {:error, Stytch.Error.t()}
  def update(organization_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, body: body],
      call: {Stytch.Organizations, :update},
      url: "/v1/b2b/organizations/#{organization_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {200, {Stytch.Organizations, :update_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:create_200_json_resp) do
    [
      organization: {Stytch.Organization, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:delete_200_json_resp) do
    [organization_id: {:string, :generic}, request_id: {:string, :generic}, status_code: :integer]
  end

  def __fields__(:get_200_json_resp) do
    [
      organization: {Stytch.Organization, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:search_200_json_resp) do
    [
      organizations: [{Stytch.Organization, :t}],
      request_id: {:string, :generic},
      results_metadata: {Stytch.Organizations, :search_200_json_resp_results_metadata},
      status_code: :integer
    ]
  end

  def __fields__(:search_200_json_resp_results_metadata) do
    [next_cursor: {:string, :generic}, total: :integer]
  end

  def __fields__(:update_200_json_resp) do
    [
      organization: {Stytch.Organization, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end
end
