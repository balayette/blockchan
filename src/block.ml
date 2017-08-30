open Listext

type t =
  { id : int;
    version : int;
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

let get_version bl = bl.version

let get_transactions_hashes transactions =
  let rec aux l acc = match l with
    | e::l -> aux l ((Transaction.get_hash e) :: acc)
    | [] -> acc
  in aux transactions []

let block_hash timestamp transactions id =
  Crypto.block_hash timestamp (get_transactions_hashes transactions) id


let create_block version id prev_hash transactions timestamp hash =
  {id; version; prev_hash; transactions; timestamp; hash}

let genesis_block () =
  create_block 0 0 "Genesis" [] (int_of_float (Unix.time ())) (block_hash 0 [] 0)

let new_block last_block transactions =
  let id = (get_id last_block) + 1 in
  let timestamp = int_of_float (Unix.time ()) in
  let hash = block_hash timestamp transactions id in
  create_block last_block.version id last_block.hash transactions timestamp hash

let print_block b =
  Printf.printf "BLOCK :\nversion : %d\nid : %d\nprev_hash : %s\ntransactions : %s\ntimestamp : %d\nhash : %s\n#############\n\n\n"
    (get_version b)
    (get_id b)
    (get_previous_hash b)
    (List.repr_of_hashes (List.map (Transaction.get_hash) (get_transactions b)))
    (get_timestamp b)
    (get_hash b)

let block_of_json_ds bl =
  let open Json_ds_t in
  let transactions = List.map (Transaction.transaction_of_json_ds) bl.transactions in
  let filtered = List.remove_options transactions in
  create_block bl.version bl.id bl.prev_hash filtered bl.timestamp bl.hash

let json_ds_of_block bl =
  let i = get_id bl 
  and ph = get_previous_hash bl
  and trs = get_transactions bl 
  and ts = get_timestamp bl
  and h = get_hash bl in
  let open Json_ds_t in
  { id = i;
    version = 1;
    prev_hash = ph;
    transactions = List.map (Transaction.json_ds_of_transaction) trs;
    timestamp = ts;
    hash = h
  }
