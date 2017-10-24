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

let post_request body transactions transaction_count =
  (* let rec aux l = match l with *)
  (*   | e::l -> Printf.printf "%s\n%!" e; aux l *)
  (*   | [] -> () *)
  (* in aux body; *)
  (body |> Cohttp_lwt.Body.to_string
   >|= (fun s ->
       Printf.printf "Body : %s\n%!" s;
       try (
         let t_ds = Json_ds_j.transaction_data_json_of_string s in
         match Transaction_data.transaction_data_of_json_ds t_ds with
           | None -> ("", `Bad_request)
           | Some t_data -> (
               let t = Transaction.new_transaction t_data in
               transactions := List.append !transactions [t];
               transaction_count := !transaction_count + 1;
               ("Ok", `OK)
             )
       )
       with Yojson.Json_error _ -> (
           Printf.printf "FAILED\n%!"; ("Bad JSON", `Bad_request)
         )
     )
  )

let process_request req body transactions trans_count =
  let uri = req |> Request.uri |> Uri.path in
  match uri |> server_command_of_path with
  | UNKNOWN -> Lwt.return ("", `Not_found)
  | GET_BLOCKS -> Lwt.return (blocks_request (req |> Request.uri))
  | POST_TRANSACTION -> post_request body transactions trans_count

let server =
  let transactions = ref [] in
  let trans_count = ref 0 in
  let callback _conn req body =
    Printf.printf "Path : %s\n%!" (req |> Request.uri |> Uri.path_and_query);
    let%lwt (resp, code) = process_request req body transactions trans_count in
    (fun r -> Printf.printf "Count : %d, Response : %s\n%!" !trans_count r; r) =|< (Lwt.return resp)
    >>= (fun body ->
        (match !trans_count with
        | _ when !trans_count <= 2 -> ()
        | _ -> (
            Printf.printf "Creating a new block\n%!";
            let block_count = Fs.get_block_count "./blockchan_data/" in
            let prev = Fs.get_block "./blockchan_data/" block_count in
            let b = Block.new_block prev !transactions in
            Block.print_block b;
            Fs.write_block "./blockchan_data/" b;
            Fs.write_block_count "./blockchan_data/" (block_count + 1);
            transactions := [];
            trans_count := 0;
          );
        );
        Server.respond_string ~status:code ~body ();)
  in
  Server.create ~mode:(`TCP (`Port 8000)) (Server.make ~callback ())

let () =
  Printf.printf "Server started\n%!";
  Fs.init_fs_exn "./blockchan_data/" "127.0.0.1";
  let g = Block.genesis_block () in
  Fs.write_block "./blockchan_data/" g;
  Fs.write_block_count "./blockchan_data/" 0;
  ignore (Lwt_main.run server)































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
