(* Auto-generated from "json_ds.atd" *)


type transaction_json = {
  data: string;
  hash: string;
  data_len: int;
  timestamp: int
}

type block_json = {
  id: int;
  prev_hash: string;
  transactions: transaction_json list;
  timestamp: int;
  hash: string
}

type blockchain_json = { count: int; blocks: block_json list }
