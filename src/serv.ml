open Lwt
open Cohttp
open Cohttp_lwt_unix

type server_commands =
  | GET_BLOCKS
  | POST_TRANSACTION
  | UNKNOWN

let path_of_server_command = function
  | GET_BLOCKS -> "/get"
  | POST_TRANSACTION -> "/transaction"
  | UNKNOWN -> ""

let server_command_of_path = function
  | "/get" -> GET_BLOCKS
  | "/transaction" -> POST_TRANSACTION
  | _ -> UNKNOWN

let server =
  let callback _conn req body =
    let uri = req |> Request.uri |> Uri.path |> server_command_of_path in
    Printf.printf "Path : %s\n" (req |> Request.uri |> Uri.path);
    let (resp, code) = match uri with UNKNOWN -> ("nok", `Not_found) | _ -> ("Ok", `OK) in
    (fun r -> Printf.sprintf "%s" r) =|< (Lwt.return resp)
    >>= (fun body -> Server.respond_string ~status:code ~body ())
  in
  Server.create ~mode:(`TCP (`Port 8000)) (Server.make ~callback ())

let () = ignore (Lwt_main.run server)
