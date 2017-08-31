(** blockchan_data directory already exists **)
exception Directory_exists of string

(** Could not create the directory **)
exception Directory_creation_failed of string

(** Could not post the reply because the thread doesn't exist **)
exception Reply_post_failed of string

exception Block_doesnt_exist of string

let create_dir path =
  Printf.printf "Creating directory %s\n" path;
  Unix.mkdir path 0o755;
  print_string "Directory created\n"

let init_fs_exn path ip =
  try
    if Sys.is_directory path then (
      raise (Directory_exists path)
    )
    else (
      raise (Directory_creation_failed path)
    )
  with
    Sys_error _ -> (
      create_dir path;
      Printf.printf "Creating %s/server\n" path;
      Core.Out_channel.write_lines (path ^ "/server") [ip];
      print_string "Created\n";
      create_dir (path ^ "/blocks");
      create_dir (path ^ "/blockchan");
      create_dir (path ^ "/blockchan/boards");
      create_dir (path ^ "/blockchan/boards/g");
      create_dir (path ^ "/blockchan/boards/cg");
      create_dir (path ^ "/blockchan/boards/b");
    )

let write_reply_count path count =
  Core.Out_channel.write_all (path ^ "/count") (string_of_int count)

let write_reply path index timestamp username text =
  Core.Out_channel.write_lines (path ^ "/" ^ (string_of_int index)) [string_of_int timestamp; username; text];
  write_reply_count path index




let prop_thread path board thash title username text timestamp =
  let b = Transaction_data.string_of_board board in
  Printf.printf "Creating a new thread with hash : %s" thash;
  let complete_path = Printf.sprintf "%s/blockchan/boards/%s/%s/" path b thash in
  create_dir complete_path;
  Core.Out_channel.write_lines (complete_path ^ "/title") [title];
  write_reply complete_path 0 timestamp username text

let get_reply_count path =
  Core.In_channel.read_all (path ^ "/count") |> String.trim |> int_of_string;;


let prop_reply path board thash username text timestamp =
  Printf.printf "Creating a new reply\n";
  let b = Transaction_data.string_of_board board in
  let complete_path = Printf.sprintf "%s/blockchan/boards/%s/%s/" path b thash in
  try (
    if Sys.is_directory complete_path then (
      Printf.printf "Writing the reply to %s" complete_path;
      let index = (get_reply_count complete_path) + 1 in
      write_reply complete_path index timestamp username text;
    )
    else (
      raise (Reply_post_failed (Printf.sprintf "Path : %s" complete_path))
    )
  )
  with
    Sys_error _ -> (
      raise (Reply_post_failed (Printf.sprintf "Path : %s" complete_path))
    )


let propagate_transaction path transaction =
  let td = Transaction.get_data transaction in
  let thash = Transaction_data.get_thread_hash td
  and title = Transaction_data.get_thread_name td
  and username = Transaction_data.get_username td
  and text = Transaction_data.get_text td
  and timestamp = Transaction_data.get_timestamp td
  and board = Transaction_data.get_board td
  and kind = Transaction_data.get_kind td in
  match kind with
  | Transaction_data.NEW_THREAD -> prop_thread path board (Crypto.thread_hash td) title username text timestamp
  | Transaction_data.REPLY -> prop_reply path board thash username text timestamp
  | Transaction_data.ARCHIVE -> ()


let rec apply_transactions path trs =
  match trs with
  | [] -> ()
  | e::l -> propagate_transaction path e; apply_transactions path l

let write_block path b =
  apply_transactions path (Block.get_transactions b);
  let jds = Block.json_ds_of_block b in
  let str = Json_ds_j.string_of_block_json jds in
  Core.Out_channel.write_all (Printf.sprintf "%s/blocks/%d.json" path (Block.get_id b)) str


let iter_blocks ?(low=0) ?(count=(-1)) path f =
  let rec aux index count =
    let p = Printf.sprintf "%s/blocks/%d.json" path index in
    if ((Sys.file_exists p) && (count <> 0)) then (
      let content = Core.In_channel.read_all p in
      let block = Block.block_of_string content in
      f block;
      aux (index + 1) (count - 1)
    )
  in aux low count

let for_all_blocks ?(low=0) ?(count=(-1)) path f =
  let rec aux index count =
    let p = Printf.sprintf "%s/blocks/%d.json" path index in
    if ((Sys.file_exists p) && (count <> 0)) then (
      let content = Core.In_channel.read_all p in
      let block = Block.block_of_string content in
      f block && aux (index + 1) (count - 1)
    )
    else (
      true
    )
  in aux low count


let get_blocks ?(low=0) ?(count=(-1)) path =
  let rec aux index count =
    let p = Printf.sprintf "%s/blocks/%d.json" path index in
    if ((Sys.file_exists p) && (count <> 0)) then (
      let content = Core.In_channel.read_all p in
      let block = Block.block_of_string content in
      block :: (aux (index + 1) (count - 1))
    )
    else (
      []
    )
  in aux low count

let get_blocks' ?(low=0) ?(count=(-1)) path =
  let rec aux index count acc =
    let p = Printf.sprintf "%s/blocks/%d.json" path index in
    if ((Sys.file_exists p) && (count <> 0)) then (
      let content = Core.In_channel.read_all p in
      let block = Block.block_of_string content in
      aux (index + 1) (count - 1) (block :: acc)
    )
    else (
      acc
    )
  in aux low count [] |> List.rev

let get_block_json path id =
  let path = Printf.sprintf "%s/blocks/%d.json" path id in
  if Sys.file_exists path then (
    Some (Core.In_channel.read_all path)
  )
  else (
    None
  )

let get_block path id =
  let b = get_blocks ~low:id ~count:1 path in
  if List.length b = 1 then
    List.hd b
  else
    raise (Block_doesnt_exist (Printf.sprintf "Block id : %d" id))

let write_all_blocks path =
  iter_blocks path (fun b -> apply_transactions path (Block.get_transactions b))


let get_blocks_json ?(low=0) ?(count=10) path =
  let rec aux index count =
    if count > 0 then (
      match get_block_json path index with
      | None -> []
      | Some b -> b :: (aux (index + 1) (count - 1))
    )
    else ( [] )
  in aux low count


(* Not implemented *)
let check_individual_blocks path = failwith "Not implemented"

(* Not implemented *)
let check_blockchain path = failwith "Not implemented"
