defmodule Stytch.OAuth do
  @moduledoc """
  Provides API endpoints related to o auth
  """

  @default_client Stytch.Client

  @doc """
  Authenticate OAuth
  """
  @spec authenticate(body :: map, opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def authenticate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.OAuth, :authenticate},
      url: "/v1/b2b/oauth/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @doc """
  Authenticate discovery OAuth
  """
  @spec authenticate_discovery(body :: map, opts :: keyword) ::
          {:ok, map} | {:error, Stytch.Error.t()}
  def authenticate_discovery(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.OAuth, :authenticate_discovery},
      url: "/v1/b2b/oauth/discovery/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @doc """
  Use Google for discovery

  ## Options

    * `public_token`

  """
  @spec discovery_google(opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def discovery_google(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:public_token])

    client.request(%{
      args: [],
      call: {Stytch.OAuth, :discovery_google},
      url: "/v1/b2b/public/oauth/google/discovery/start",
      method: :get,
      query: query,
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @doc """
  Use Microsoft for discovery

  ## Options

    * `public_token`

  """
  @spec discovery_microsoft(opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def discovery_microsoft(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:public_token])

    client.request(%{
      args: [],
      call: {Stytch.OAuth, :discovery_microsoft},
      url: "/v1/b2b/public/oauth/microsoft/discovery/start",
      method: :get,
      query: query,
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @type login_github_307_json_resp :: %{
          redirect_url: String.t() | nil,
          request_id: String.t() | nil,
          status_code: integer | nil
        }

  @doc """
  Login with GitHub

  ## Options

    * `public_token`

  """
  @spec login_github(opts :: keyword) :: :ok | {:error, Stytch.Error.t()}
  def login_github(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:public_token])

    client.request(%{
      args: [],
      call: {Stytch.OAuth, :login_github},
      url: "/v1/b2b/public/oauth/github/start",
      method: :get,
      query: query,
      response: [
        {307, {Stytch.OAuth, :login_github_307_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type login_google_302_json_resp :: %{
          redirect_url: String.t() | nil,
          request_id: String.t() | nil,
          status_code: integer | nil
        }

  @doc """
  Login with Google

  ## Options

    * `public_token`

  """
  @spec login_google(opts :: keyword) :: :ok | {:error, Stytch.Error.t()}
  def login_google(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:public_token])

    client.request(%{
      args: [],
      call: {Stytch.OAuth, :login_google},
      url: "/v1/b2b/public/oauth/google/start",
      method: :get,
      query: query,
      response: [
        {302, {Stytch.OAuth, :login_google_302_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type login_hubspot_307_json_resp :: %{
          redirect_url: String.t() | nil,
          request_id: String.t() | nil,
          status_code: integer | nil
        }

  @doc """
  Login with HubSpot

  ## Options

    * `public_token`

  """
  @spec login_hubspot(opts :: keyword) :: :ok | {:error, Stytch.Error.t()}
  def login_hubspot(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:public_token])

    client.request(%{
      args: [],
      call: {Stytch.OAuth, :login_hubspot},
      url: "/v1/b2b/public/oauth/hubspot/start",
      method: :get,
      query: query,
      response: [
        {307, {Stytch.OAuth, :login_hubspot_307_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type login_microsoft_302_json_resp :: %{
          redirect_url: String.t() | nil,
          request_id: String.t() | nil,
          status_code: integer | nil
        }

  @doc """
  Login with Microsoft

  ## Options

    * `public_token`

  """
  @spec login_microsoft(opts :: keyword) :: :ok | {:error, Stytch.Error.t()}
  def login_microsoft(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:public_token])

    client.request(%{
      args: [],
      call: {Stytch.OAuth, :login_microsoft},
      url: "/v1/b2b/public/oauth/microsoft/start",
      method: :get,
      query: query,
      response: [
        {302, {Stytch.OAuth, :login_microsoft_302_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type login_slack_307_json_resp :: %{
          redirect_url: String.t() | nil,
          request_id: String.t() | nil,
          status_code: integer | nil
        }

  @doc """
  Login with Slack

  ## Options

    * `public_token`

  """
  @spec login_slack(opts :: keyword) :: :ok | {:error, Stytch.Error.t()}
  def login_slack(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:public_token])

    client.request(%{
      args: [],
      call: {Stytch.OAuth, :login_slack},
      url: "/v1/b2b/public/oauth/slack/start",
      method: :get,
      query: query,
      response: [
        {307, {Stytch.OAuth, :login_slack_307_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:login_github_307_json_resp) do
    [redirect_url: {:string, :generic}, request_id: {:string, :generic}, status_code: :integer]
  end

  def __fields__(:login_google_302_json_resp) do
    [redirect_url: {:string, :generic}, request_id: {:string, :generic}, status_code: :integer]
  end

  def __fields__(:login_hubspot_307_json_resp) do
    [redirect_url: {:string, :generic}, request_id: {:string, :generic}, status_code: :integer]
  end

  def __fields__(:login_microsoft_302_json_resp) do
    [redirect_url: {:string, :generic}, request_id: {:string, :generic}, status_code: :integer]
  end

  def __fields__(:login_slack_307_json_resp) do
    [redirect_url: {:string, :generic}, request_id: {:string, :generic}, status_code: :integer]
  end
end
