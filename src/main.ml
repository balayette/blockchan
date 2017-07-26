open Listext

(* Make sure to change this to reflect the underlying data structures.
   `| NEW_THREAD of thread`, for example
*)
type transaction_type =
  | NEW_THREAD
  | REPLY
  | ARCHIVE

(* This function should also reflect the underlying data structures.
   `| NEW_THREAD(t) -> new_thread t`, for example
*)
let int_of_transaction_type = function
  | NEW_THREAD -> 0
  | REPLY -> 1
  | ARCHIVE -> 2

type transaction =
  { data : string;
    hash : string;
    data_len : int;
  }

type block =
  { id : int;
    prev_hash : string;
    transactions : transaction list;
    timestamp : int;
    hash : string;
  }

type blockchain =
  { count : int;
    blocks : block list;
  }



let print_transaction t =
  Printf.printf "TRANSACTION:\ndata : %s\nhash : %s\nlength: %d\n-------------\n\n\n" t.data t.hash t.data_len

let print_block b =
  Printf.printf "BLOCK :\nid : %d\nprev_hash : %s\ntransactions : %s\ntimestamp : %d\nhash : %s\n#############\n\n\n"
    b.id
    b.prev_hash
    (List.repr_of_hashes (List.map (fun (t : transaction) -> t.hash) b.transactions))
    b.timestamp
    b.hash

let print_blockchain bl =
  Printf.printf "BLOCKCHAIN :\ncount : %d\nblocks : %s\n*************\n\n\n\n"
    bl.count
    (List.repr_of_hashes (List.map (fun (b : block) -> b.hash) bl.blocks))



let hash_data data = Digestif.SHA256.Bytes.digest data |> Digestif.SHA256.Bytes.to_hex
let transaction_hash = hash_data
let valid_transaction_hash t = transaction_hash t.data == t.hash

let block_hash timestamp transactions id =
  let rec concat_hashes (l : transaction list) acc = match l with
    | e::l -> concat_hashes l (acc ^ e.hash)
    | [] -> acc
   in (string_of_int timestamp) ^ (concat_hashes transactions "") ^ (string_of_int id) |> hash_data


let new_transaction data =
  match String.length data with
  | x when x > 1024 -> None
  | data_len ->
    let hash = transaction_hash data in
    Some {data; hash; data_len}

let new_block bl transactions =
  let last_block = List.hd bl.blocks in
  let id = last_block.id + 1 in
  let timestamp = id + 10 in
  let hash = block_hash timestamp transactions id in
  { id; prev_hash = last_block.hash; transactions; timestamp; hash}


let new_blockchain () =
  let count = 1 in
  let genesis_block = {id = 0; prev_hash = "Fucking genesis"; transactions = []; timestamp = 0; hash = block_hash 0 [] 0 } in
  print_string "Genesis block : \n";
  print_block genesis_block;
  {count; blocks = [genesis_block]}

(* TOOO : introduce actual error handling *)
let add_block bl b =
  let last_block = List.hd bl.blocks in
  if last_block.hash <> b.prev_hash then (
    Printf.printf "The block with hash %s doesn't match the previous block : expected prev_hash = %s, got prev_hash = %s\n" b.hash last_block.hash b.prev_hash; None
  )
  else (
    if b.id <> last_block.id + 1 then (
      Printf.printf "The block with hash %s doesn't match the previous block : expected id = %d, got id = %d" b.hash (last_block.id + 1) b.id; None
    )
    else (
      let actual_hash = block_hash b.timestamp b.transactions b.id in
      if actual_hash <> b.hash then (
        Printf.printf "The block has hash %s, expected %s" b.hash actual_hash; None
      )
      else (
        Printf.printf "The block with hash %s is valid, adding it to the blockchain\n" b.hash;
        Some {count = bl.count + 1; blocks = b::bl.blocks}
      )
    )
  )

let greetings () =
  print_string "############################\n";
  print_string "##     BLOCKCHAN SERVER   ##\n";
  print_string "############################\n";;

let () =
  greetings ();
  let a = new_transaction "Genesis transaction" in
  let b = new_transaction "Next transaction" in
  match (a, b) with
  | (Some t1, Some t2) -> (
      print_transaction t1; print_transaction t2;
      let blchain = new_blockchain () in
      print_blockchain blchain;
      let nb = new_block blchain [t1; t2] in
      match add_block blchain nb with
      | None -> ()
      | Some nblchain -> print_blockchain nblchain;
    )
  | _ -> print_string "invalid transaction"
