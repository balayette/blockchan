(** blockchan_data directory already exists **)
exception Directory_exists of string

(** Could not create the directory **)
exception Directory_creation_failed of string

(** Could not post the reply because the thread doesn't exist **)
exception Reply_post_failed of string

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
  Core.Out_channel.write_all (Printf.sprintf "%s/blocks/%d.json" path (Block.get_id b)) str;
