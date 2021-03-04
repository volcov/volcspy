import Config

config :volcspy, base_url: System.get_env("VOLCSPY_BASE_URL")
config :volcspy, :http_client, HTTPoison
