defmodule Stytch.JWKSTest do
  use ExUnit.Case, async: true

  alias Stytch.JWKS

  @valid_jwt "eyJhbGciOiJSUzI1NiIsImtpZCI6Imp3ay10ZXN0LTk2YWM0NjE0LWZlMzQtNDBhNS05YzJlLWE1ZTk4YThmYTU1ZiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsicHJvamVjdC10ZXN0LWYyMDJlZGIwLTNmNDgtNDUyYi1hNmRmLTgzYjUxNjM0MmJiZSJdLCJleHAiOjE3NTA5OTY1OTIsImh0dHBzOi8vc3R5dGNoLmNvbS9vcmdhbml6YXRpb24iOnsib3JnYW5pemF0aW9uX2lkIjoib3JnYW5pemF0aW9uLXRlc3QtYTBhZmVhMGYtMGRiZS00ZWY1LTg4YmYtN2U5ZTdhMDZkYWI4Iiwic2x1ZyI6InRvZ2V0aGVyIn0sImh0dHBzOi8vc3R5dGNoLmNvbS9zZXNzaW9uIjp7ImlkIjoibWVtYmVyLXNlc3Npb24tdGVzdC0zYTQyOTUxNi0zYmNlLTQ1YmItYjY3OS1mYWVmZGRjZWRjZmEiLCJzdGFydGVkX2F0IjoiMjAyNS0wNi0yN1QwMzo1MTozMloiLCJsYXN0X2FjY2Vzc2VkX2F0IjoiMjAyNS0wNi0yN1QwMzo1MTozMloiLCJleHBpcmVzX2F0IjoiMjAyNS0wNi0yN1QwNDo1MTozMloiLCJhdHRyaWJ1dGVzIjp7InVzZXJfYWdlbnQiOiIiLCJpcF9hZGRyZXNzIjoiIn0sImF1dGhlbnRpY2F0aW9uX2ZhY3RvcnMiOlt7InR5cGUiOiJzc28iLCJkZWxpdmVyeV9tZXRob2QiOiJzc29fb2lkYyIsImxhc3RfYXV0aGVudGljYXRlZF9hdCI6IjIwMjUtMDYtMjdUMDM6NTE6MzJaIiwib2lkY19zc29fZmFjdG9yIjp7ImlkIjoib2lkYy1tZW1iZXItcmVnaXN0cmF0aW9uLXRlc3QtMTBmNGNkODctNTg1OC00MTZkLWI1MGItZGM2MTM3YWZkNzgzIiwicHJvdmlkZXJfaWQiOiJvaWRjLWNvbm5lY3Rpb24tdGVzdC0zYzA4NjY3MC1hYmI5LTQzMjktYmNlOC0wZTJmYzlhZDUyNDMiLCJleHRlcm5hbF9pZCI6IjAwdXNwdzJ0ZjU2dkJBejBZNjk3In19XSwicm9sZXMiOlsic3R5dGNoX21lbWJlciJdfSwiaWF0IjoxNzUwOTk2MjkyLCJpc3MiOiJzdHl0Y2guY29tL3Byb2plY3QtdGVzdC1mMjAyZWRiMC0zZjQ4LTQ1MmItYTZkZi04M2I1MTYzNDJiYmUiLCJuYmYiOjE3NTA5OTYyOTIsInN1YiI6Im1lbWJlci10ZXN0LTVkZTAxMTA5LWJhZTEtNGE0ZC05MDhmLWY3YTI2NzIwZjRmMiJ9.qvKGZYvTM1endd2uELkGewhoJZ8z-gWcuPwdIRHESSfDisoEZo4OW02NFbeoOiBKNqzjG3iLrdnrMFj3xYBcDWeascqt2YeeY1sKS5xe7OZp7TkMUT5SOB51U_sXftNCH9AGUe6U2hliHzJSv36xQidyWAxhVFwnl9IWXg3A4g1NzIisIwofJWldgEltFud-982HznKHPcQYOE3UyDvh_XS8ubxaQ__J7JcUckXv5lmASgwCITzaTIEoX3G4Wpt0K4QJvAnv7rUIgpkzbg_lePRImGDzSurj6yDKMwWwMzS5o7ZDKyrxsEO1yOk7Bs1WfF5FW6LF9utpfeEXWVldkw"

  @valid_jwk %{
    "alg" => "RS256",
    "e" => "AQAB",
    "key_ops" => ["verify"],
    "kid" => "jwk-test-96ac4614-fe34-40a5-9c2e-a5e98a8fa55f",
    "kty" => "RSA",
    "n" =>
      "wBQvcXVISfN9YQc1G3BwvmII73z7cshOwJFheHNr-WNO5pPJfVjkjuZ3vWgZHDGmdJKXuXtTR2MJdJXBhDnV2EeAY7qqQDChSGCNFzxNLj2Rovg5xeRhyRLr3wAbz_6Bme9KDtDqdQkt7bZJF1rwkqINQg7QKLdTxhgnulfM5gPgAH6af9-WwYSB94CrWS5cVH149hq3Y9mFNK5-u2AVJmOlmvCRFHfJ3PCEeiWwbJH_mCigxGLA6zsdJgEnwywwWsv6SOb99YygNtBjv3jKTI21tLs_tbBGsrlvdXO38i-4i97actm1X2vF80XBiMfp3gJBuA_BRQPb7pNEo6ZXSw",
    "use" => "sig",
    "x5c" => [
      "MIICvTCCAaWgAwIBAgIBATANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQKEwZTdHl0Y2gwHhcNMjUwNjI3MDM1NDE2WhcNMzUwNjI3MDM1NDE2WjARMQ8wDQYDVQQKEwZTdHl0Y2gwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAFC9xdUhJ831hBzUbcHC+YgjvfPtyyE7AkWF4c2v5Y07mk8l9WOSO5ne9aBkcMaZ0kpe5e1NHYwl0lcGEOdXYR4BjuqpAMKFIYI0XPE0uPZGi+DnF5GHJEuvfABvP/oGZ70oO0Op1CS3ttkkXWvCSog1CDtAot1PGGCe6V8zmA+AAfpp/35bBhIH3gKtZLlxUfXj2Grdj2YU0rn67YBUmY6Wa8JEUd8nc8IR6JbBskf+YKKDEYsDrOx0mASfDLDBay/pI5v31jKA20GO/eMpMjbW0uz+1sEayuW91c7fyL7iL3tpy2bVfa8XzRcGIx+neAkG4D8FFA9vuk0SjpldLAgMBAAGjIDAeMA4GA1UdDwEB/wQEAwIHgDAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBCwUAA4IBAQCqhGBtzl2H0+nPK+ZsIiDOc1K2G6HfbmdfhUd/q/9p3KjQ+bFB5aJ6S6pySA0uXLPE1jikdoX0ZEbJ8Zguy5iwUmFj7ZNco1zIQsVIyHyGnPao32Qhki0n6k0J15tPlQD18kW/ji4tAqZECHdoksFOtrMPaDC1JcnpYlknyhAubRUmIXaEmHEZvhjuLNVxC/upAXKhynvdJZafE4XpK55WqD+BiaCQh5nL3ZsJLcVPdx8k7D8Tycq9sG4nAuBpNo9dXTjdNNISxwLysi5LjjOk9XGqWUWyjKlXEuH7PO3g2Gr64mCenFJuaOM8shIQJIFlH8scGUVdyz+y8+lIv9vz"
    ]
  }

  describe "verify/2" do
    setup do
      %{name: Module.concat([Stytch.JWKS, "Test#{System.unique_integer([:positive])}"])}
    end

    test "verifies a signed JWT", %{name: name} do
      jwk = JOSE.JWK.from(@valid_jwk)
      Application.put_env(:stytch, name, jwks: [jwk])

      assert {:ok, %{"sub" => "member-test-5de01109-bae1-4a4d-908f-f7a26720f4f2"}} =
               JWKS.verify(@valid_jwt, name: name)
    end

    test "returns error when no JWKs are available", %{name: name} do
      Application.put_env(:stytch, name, jwks: [])

      assert {:error, %RuntimeError{message: "No JWKs available for " <> _}} =
               JWKS.verify(@valid_jwt, name: name)
    end

    test "returns error when JWT verification fails", %{name: name} do
      jwk = JOSE.JWK.from(@valid_jwk)
      Application.put_env(:stytch, name, jwks: [jwk])

      invalid_jwt = @valid_jwt <> "invalid"

      assert {:error, %RuntimeError{message: "Failed to verify JWT"}} =
               JWKS.verify(invalid_jwt, name: name)
    end
  end
end
