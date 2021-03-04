ExUnit.start()

Application.put_env(:volcspy, :base_url, "kleber")

Mox.defmock(HTTPoison.BaseMock, for: HTTPoison.Base)
Application.put_env(:volcspy, :http_client, HTTPoison.BaseMock)
