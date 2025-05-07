import Config

config :oapi_generator,
  default: [
    naming: [
      rename: [
        {~r/MultiFactorAuthenticationMFAOneTimePasscodesOTPsForMFA/, "OTP"}
      ]
    ],
    output: [
      base_module: Stytch,
      location: "lib",
      operation_subdirectory: "operations",
      schema_subdirectory: "schemas"
    ]
  ]
