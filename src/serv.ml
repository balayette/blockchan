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


let blocks_request uri =
  let id = Uri.get_query_param uri "id" in
  match id with
  | None -> ("", `Bad_request)
  | Some x -> (
    try (
      let x = int_of_string x in
      match Fs.get_block_json "./blockchan_data" x with
      | None -> ("", `OK)
      | Some b -> (b, `OK)
    )
    with Failure _ -> ("", `Bad_request)
  )

let post_request uri transactions = ("", `Bad_request)

let process_request req transactions =
  let uri = req |> Request.uri |> Uri.path in
  match uri |> server_command_of_path with
  | UNKNOWN -> ("", `Not_found)
  | GET_BLOCKS -> blocks_request (req |> Request.uri)
  | POST_TRANSACTION -> post_request (req |> Request.uri) transactions

let server =
  let transactions = ref [] in
  let callback _conn req body =
    Printf.printf "Path : %s\n%!" (req |> Request.uri |> Uri.path_and_query);
    let (resp, code) = process_request req transactions in
    (fun r -> Printf.printf "Response : %s\n%!" r; r) =|< (Lwt.return resp)
    >>= (fun body -> Server.respond_string ~status:code ~body ())
  in
  Server.create ~mode:(`TCP (`Port 8000)) (Server.make ~callback ())

let () = ignore (Lwt_main.run server)































(* let () = *)
  (* Fs.init_fs_exn "./blockchan_data/" "127.0.0.1"; *)
  (* let td = Transaction_data.new_transaction_data *)
  (*   ~username:"Nicolas" *)
  (*   ~thread_name:"I love this" *)
  (*   ~text:"I'm posting a new thread" *)
  (*   Transaction_data.CONSUMER_TECH *)
  (*   Transaction_data.NEW_THREAD *)
  (*   in *)
  (*   Transaction_data.print_transaction_data td; *)
  (*   let tra = Transaction.new_transaction td in *)
  (*   Transaction.print_transaction tra; *)
  (*   let thash = Crypto.thread_hash td in *)
  (*   let td2 = Transaction_data.new_transaction_data *)
  (*   ~text:"And I'm answering" *)
  (*   ~thread_hash:thash *)
  (*   Transaction_data.CONSUMER_TECH *)
  (*   Transaction_data.REPLY *)
  (*   in *)
  (*   Transaction_data.print_transaction_data td2; *)
  (*   let tra2 = Transaction.new_transaction td2 in *)
  (*   let g = Block.genesis_block () in *)
  (*   let b = Block.new_block g [tra; tra2] in *)
  (*   Block.print_block b; *)
  (*   Fs.write_block "./blockchan_data/" g; *)
  (*   Fs.write_block "./blockchan_data/" b; *)
  (* Fs.get_block "./blockchan_data" 0 |> Block.print_block *)
  (* let bs = Fs.get_blocks_json "./blockchan_data" in *)
  (* List.iter (fun b -> print_string b; print_string "\n") bs *)
