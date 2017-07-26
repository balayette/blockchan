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

let genesis_block () =
  {id = 0; prev_hash = "Genesis"; transactions = []; timestamp = 0; hash = (block_hash 0 [] 0)}

let new_block last_block transactions =
  let id = (get_id last_block) + 1 in
  let timestamp = id + 10 in
  let hash = block_hash timestamp transactions id in
  { id; prev_hash = last_block.hash; transactions; timestamp; hash}

let print_block b =
  Printf.printf "BLOCK :\nid : %d\nprev_hash : %s\ntransactions : %s\ntimestamp : %d\nhash : %s\n#############\n\n\n"

    (get_id b)
    (get_previous_hash b)
    (List.repr_of_hashes (List.map (fun (t : Transaction.t) -> Transaction.hash t) (get_transactions b)))
    (get_timestamp b)
    (get_hash b)
