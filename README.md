# Stytch Client for Elixir

_Wrapper and interface for the Stytch B2B SaaS authentication API in Elixir_

---

This repository is a work in progress.

## Installation

This library is not currently available on Hex.pm, so install it via GitHub and run mix deps.get:

```elixir
def deps do
  [
    {:stytch, github: "togethercomputer/stytch-elixir", branch: "main"}
  ]
end
```

## Code Generation

At the time of writing, Stytch does not publish an OpenAPI description for their API.
A hand-crafted description [is available](vendor/stytch-openapi.yml) in this repository.
It was generated based on a public Postman collection and enhanced by hand — so don't expect full coverage of the API.

Code generation provided by the [OpenAPI Generator for Elixir](https://github.com/aj-foster/open-api-generator).

## License

Please see [LICENSE](LICENSE) for licensing details.
