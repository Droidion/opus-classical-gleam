import gleam/erlang/process
import mist
import opus_classical/db
import opus_classical/env
import opus_classical/router
import opus_classical/web
import wisp
import wisp/wisp_mist

pub fn main() {
  wisp.configure_logger()
  let env_vars = env.load_env()
  let context =
    web.Context(
      conn: db.db_connect(env_vars.postgres),
      env_vars: env_vars,
      static_directory: static_directory(),
    )
  let handler = router.handle_request(_, context)

  let assert Ok(_) =
    wisp_mist.handler(handler, env_vars.secret_key)
    |> mist.new
    |> mist.port(env_vars.server_port)
    |> mist.start_http

  process.sleep_forever()
}

pub fn static_directory() -> String {
  let assert Ok(priv_directory) = wisp.priv_directory("opus_classical")
  priv_directory <> "/static"
}
