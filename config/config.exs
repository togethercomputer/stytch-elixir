import Config

config :oapi_generator,
  default: [
    naming: [
      group: [
        AuthenticationFactor,
        Member
      ],
      rename: [
        {~r/MultiFactorAuthenticationMFAOneTimePasscodesOTPsForMFA/, "OTP"},
        {~r/^((?!Authentication)[A-Za-z]+)Factor$/, "AuthenticationFactor.\\1"}
      ]
    ],
    output: [
      base_module: Stytch,
      location: "lib",
      operation_subdirectory: "operations",
      schema_subdirectory: "schemas"
    ]
  ]
