type t =
  { data : Transaction_data.t;
    hash : string;
    timestamp : int;
  }

let print_transaction t =
  Printf.printf "TRANSACTION:\nhash : %s\ntimestamp : %d\n" t.hash t.timestamp;
  Transaction_data.print_transaction_data t.data;
  Printf.printf "-------------\n\n\n"

let create_transaction data hash timestamp =
  {data; hash; timestamp}

let new_transaction data =
  let hash = Crypto.transaction_hash data in
  create_transaction data hash (int_of_float (Unix.time ()))

let hash tr = tr.hash

let data tr = tr.data

let transaction_of_json_ds tj =
  let open Json_ds_t in
  let t_data = Transaction_data.transaction_data_of_json_ds tj.data in
  match t_data with
  | None -> None
  | Some x -> Some (create_transaction x tj.hash tj.timestamp)

let json_ds_of_transaction (tr : t) =
  let open Json_ds_t in
  {data = (Transaction_data.json_ds_of_transaction_data tr.data);
   hash = tr.hash;
   timestamp = tr.timestamp
  }
