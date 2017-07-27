open Listext

type t =
  { id : int;
    prev_hash : string;
    transactions : Transaction.t list;
    timestamp : int;
    hash : string;
  }

let get_hash bl = bl.hash

let get_id bl = bl.id

let get_timestamp bl = bl.timestamp

let get_transactions bl = bl.transactions

let get_previous_hash bl = bl.prev_hash

let get_transactions_hashes transactions =
  let rec aux l acc = match l with
    | e::l -> aux l ((Transaction.hash e) :: acc)
    | [] -> acc
  in aux transactions []

let block_hash timestamp transactions id =
  Crypto.block_hash timestamp (get_transactions_hashes transactions) id


let create_block id prev_hash transactions timestamp hash =
  {id; prev_hash; transactions; timestamp; hash}

let genesis_block () =
  create_block 0 "Genesis" [] (int_of_float (Unix.time ())) (block_hash 0 [] 0)

let new_block last_block transactions =
  let id = (get_id last_block) + 1 in
  let timestamp = int_of_float (Unix.time ()) in
  let hash = block_hash timestamp transactions id in
  create_block id last_block.hash transactions timestamp hash

let print_block b =
  Printf.printf "BLOCK :\nid : %d\nprev_hash : %s\ntransactions : %s\ntimestamp : %d\nhash : %s\n#############\n\n\n"
    (get_id b)
    (get_previous_hash b)
    (List.repr_of_hashes (List.map (fun (t : Transaction.t) -> Transaction.hash t) (get_transactions b)))
    (get_timestamp b)
    (get_hash b)

let block_of_json_ds bl =
  let open Json_ds_t in
  create_block bl.id bl.prev_hash (List.map (Transaction.transaction_of_json_ds) bl.transactions) bl.timestamp bl.hash

let json_ds_of_block (bl : t) =
  let open Json_ds_t in
  { id = bl.id;
    prev_hash = bl.prev_hash;
    transactions = List.map (Transaction.json_ds_of_transaction) bl.transactions;
    timestamp = bl.timestamp;
    hash = bl.hash
  }
