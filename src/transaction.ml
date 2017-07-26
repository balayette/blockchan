type t =
  { data : string;
    hash : string;
    data_len : int;
  }

let print_transaction t =
  Printf.printf "TRANSACTION:\ndata : %s\nhash : %s\nlength: %d\n-------------\n\n\n" t.data t.hash t.data_len


let new_transaction data =
  match String.length data with
  | x when x > 1024 -> None
  | data_len -> (
    let hash = Crypto.transaction_hash data in
    Some {data; hash; data_len}
  )

let hash tr = tr.hash

let data tr = tr.data

let data_len tr = tr.data_len
