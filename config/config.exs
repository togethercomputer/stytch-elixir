import Config

config :oapi_generator,
  default: [
    naming: [
      group: [
        AuthenticationFactor,
        Member,
        OIDC,
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
