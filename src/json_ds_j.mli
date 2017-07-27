(* Auto-generated from "json_ds.atd" *)


type transaction_data_json = Json_ds_t.transaction_data_json = {
  board: string;
  kind: string;
  username: string;
  thread_name: string;
  text: string;
  thread_hash: string
}

type transaction_json = Json_ds_t.transaction_json = {
  data: transaction_data_json;
  hash: string;
  timestamp: int
}

type block_json = Json_ds_t.block_json = {
  id: int;
  prev_hash: string;
  transactions: transaction_json list;
  timestamp: int;
  hash: string
}

type blockchain_json = Json_ds_t.blockchain_json = {
  count: int;
  blocks: block_json list
}

val write_transaction_data_json :
  Bi_outbuf.t -> transaction_data_json -> unit
  (** Output a JSON value of type {!transaction_data_json}. *)

val string_of_transaction_data_json :
  ?len:int -> transaction_data_json -> string
  (** Serialize a value of type {!transaction_data_json}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_transaction_data_json :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> transaction_data_json
  (** Input JSON data of type {!transaction_data_json}. *)

val transaction_data_json_of_string :
  string -> transaction_data_json
  (** Deserialize JSON data of type {!transaction_data_json}. *)

val write_transaction_json :
  Bi_outbuf.t -> transaction_json -> unit
  (** Output a JSON value of type {!transaction_json}. *)

val string_of_transaction_json :
  ?len:int -> transaction_json -> string
  (** Serialize a value of type {!transaction_json}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_transaction_json :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> transaction_json
  (** Input JSON data of type {!transaction_json}. *)

val transaction_json_of_string :
  string -> transaction_json
  (** Deserialize JSON data of type {!transaction_json}. *)

val write_block_json :
  Bi_outbuf.t -> block_json -> unit
  (** Output a JSON value of type {!block_json}. *)

val string_of_block_json :
  ?len:int -> block_json -> string
  (** Serialize a value of type {!block_json}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_block_json :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> block_json
  (** Input JSON data of type {!block_json}. *)

val block_json_of_string :
  string -> block_json
  (** Deserialize JSON data of type {!block_json}. *)

val write_blockchain_json :
  Bi_outbuf.t -> blockchain_json -> unit
  (** Output a JSON value of type {!blockchain_json}. *)

val string_of_blockchain_json :
  ?len:int -> blockchain_json -> string
  (** Serialize a value of type {!blockchain_json}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_blockchain_json :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> blockchain_json
  (** Input JSON data of type {!blockchain_json}. *)

val blockchain_json_of_string :
  string -> blockchain_json
  (** Deserialize JSON data of type {!blockchain_json}. *)

