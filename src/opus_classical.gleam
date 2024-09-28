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
  let secret_key_base = wisp.random_string(64)
  let env_vars = env.load_env()
  let context = web.Context(conn: db.db_connect(env_vars), env_vars: env_vars)
  let handler = router.handle_request(_, context)

  let assert Ok(_) =
    wisp_mist.handler(handler, secret_key_base)
    |> mist.new
    |> mist.port(8000)
    |> mist.start_http

  process.sleep_forever()
}

pub type FindSquirrelRow {
  FindSquirrelRow(name: String, owned_acorns: Int)
}
