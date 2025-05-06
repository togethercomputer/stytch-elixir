import Config

# Used for development and testing only
if project_id = System.get_env("STYTCH_PROJECT_ID") do
  config :stytch,
    default_auth: {project_id, System.fetch_env!("STYTCH_SECRET")}
else
  config :stytch,
    req_opts: [plug: {Req.Test, Stytch.Client}]
end
