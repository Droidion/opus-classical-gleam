import dot_env as dot
import dot_env/env

pub type PostgresConfig {
  PostgresConfig(
    user: String,
    password: String,
    host: String,
    database: String,
    port: Int,
  )
}

pub type EnvVars {
  EnvVars(postgres: PostgresConfig, server_port: Int, secret_key: String)
}

pub fn load_env() -> EnvVars {
  dot.load_default()
  let assert Ok(postgres_user) = env.get_string("POSTGRES_USER")
  let assert Ok(postgres_password) = env.get_string("POSTGRES_PASSWORD")
  let assert Ok(postgres_host) = env.get_string("POSTGRES_HOST")
  let assert Ok(postgres_database) = env.get_string("POSTGRES_DATABASE")
  let assert Ok(postgres_port) = env.get_int("POSTGRES_PORT")
  let assert Ok(server_port) = env.get_int("SERVER_PORT")
  let assert Ok(secret_key) = env.get_string("SECRET_KEY")
  EnvVars(
    postgres: PostgresConfig(
      user: postgres_user,
      password: postgres_password,
      host: postgres_host,
      database: postgres_database,
      port: postgres_port,
    ),
    server_port: server_port,
    secret_key: secret_key,
  )
}
