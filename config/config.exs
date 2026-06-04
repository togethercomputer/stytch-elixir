import Config

config :oapi_generator,
  default: [
    naming: [
      group: [
        AuthenticationFactor,
        Member,
        OIDC,
        RBAC,
        SAML
      ],
      rename: [
        {~r/MultiFactorAuthenticationMFAOneTimePasscodesOTPsForMFA/, "OTP"},
        {~r/^((?!Authentication)[A-Za-z]+)Factor$/, "AuthenticationFactor.\\1"},
        {"EmailOtp", "EmailOTP"},
        {"Mfa", "MFA"},
        {"Oauth", "OAuth"},
        {"Rbac", "RBAC"},
        {"Sso", "SSO"}
      ]
    ],
    output: [
      base_module: Stytch,
      location: "lib",
      operation_subdirectory: "operations",
      schema_subdirectory: "schemas",
      schema_use: Stytch.Schema,
      types: [
        error: {Stytch.Error, :t}
      ]
    ]
  ]

config :stytch,
  default_auth: {"project-test-fake", "secret-test-fake"},
  req_opts: [plug: {Req.Test, Stytch.Client}]
