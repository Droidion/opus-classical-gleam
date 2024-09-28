import dot_env as dot
import dot_env/env

pub type EnvVars {
  EnvVars(
    postgres_user: String,
    postgres_password: String,
    postgres_host: String,
    postgres_database: String,
    postgres_port: Int,
  )
}

pub fn load_env() -> EnvVars {
  dot.load_default()
  EnvVars(
    postgres_user: env.get_string_or("POSTGRES_USER", ""),
    postgres_password: env.get_string_or("POSTGRES_PASSWORD", ""),
    postgres_host: env.get_string_or("POSTGRES_HOST", ""),
    postgres_database: env.get_string_or("POSTGRES_DATABASE", ""),
    postgres_port: env.get_int_or("POSTGRES_PORT", 0),
  )
}
