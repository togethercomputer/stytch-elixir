# Stytch Client for Elixir

[![Documentation](https://img.shields.io/badge/-Documentation-4B275F?logo=elixir&logoColor=white)](https://togethercomputer.github.io/stytch-elixir)

_Wrapper and interface for the Stytch B2B SaaS authentication API in Elixir_

## What is this?

Together uses the [Elixir programming language](https://elixir-lang.org/) for several of its services.
It also uses [Stytch](https://stytch.com/) to serve some of its authentication and authorization needs.
This repository provides a wrapper around the Stytch B2B SaaS Authentication API in Elixir.

This repository is a work in progress and not necessarily meant for public consumption.

## Installation

This library is not currently available on Hex.pm, so install it via GitHub and run `mix deps.get`:

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
