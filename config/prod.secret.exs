use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :benches, Benches.Endpoint,
  secret_key_base: "7omAUTekErDDTdAx93ecIrRhwd4cWIH2zSpIjLUBS0T7QgiMQHx2PzRw0maPkCvG"

# Configure your database
config :benches, Benches.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL")
