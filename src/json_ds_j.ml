(* Auto-generated from "json_ds.atd" *)


type transaction_data_json = Json_ds_t.transaction_data_json = {
  board: string;
  kind: string;
  username: string;
  thread_name: string;
  text: string;
  thread_hash: string;
  timestamp: int
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

let write_transaction_data_json : _ -> transaction_data_json -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"board\":";
    (
      Yojson.Safe.write_string
    )
      ob x.board;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"kind\":";
    (
      Yojson.Safe.write_string
    )
      ob x.kind;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"username\":";
    (
      Yojson.Safe.write_string
    )
      ob x.username;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"thread_name\":";
    (
      Yojson.Safe.write_string
    )
      ob x.thread_name;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"text\":";
    (
      Yojson.Safe.write_string
    )
      ob x.text;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"thread_hash\":";
    (
      Yojson.Safe.write_string
    )
      ob x.thread_hash;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"timestamp\":";
    (
      Yojson.Safe.write_int
    )
      ob x.timestamp;
    Bi_outbuf.add_char ob '}';
)
let string_of_transaction_data_json ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_transaction_data_json ob x;
  Bi_outbuf.contents ob
let read_transaction_data_json = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_board = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_kind = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_username = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_thread_name = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_text = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_thread_hash = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_timestamp = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          match len with
            | 4 -> (
                match String.unsafe_get s pos with
                  | 'k' -> (
                      if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'd' then (
                        1
                      )
                      else (
                        -1
                      )
                    )
                  | 't' -> (
                      if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'x' && String.unsafe_get s (pos+3) = 't' then (
                        4
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 5 -> (
                if String.unsafe_get s pos = 'b' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'd' then (
                  0
                )
                else (
                  -1
                )
              )
            | 8 -> (
                if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' then (
                  2
                )
                else (
                  -1
                )
              )
            | 9 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'p' then (
                  6
                )
                else (
                  -1
                )
              )
            | 11 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = '_' then (
                  match String.unsafe_get s (pos+7) with
                    | 'h' -> (
                        if String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'h' then (
                          5
                        )
                        else (
                          -1
                        )
                      )
                    | 'n' -> (
                        if String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'm' && String.unsafe_get s (pos+10) = 'e' then (
                          3
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_board := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_kind := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_username := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_thread_name := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_text := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | 5 ->
            field_thread_hash := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x20;
          | 6 ->
            field_timestamp := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x40;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            match len with
              | 4 -> (
                  match String.unsafe_get s pos with
                    | 'k' -> (
                        if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'n' && String.unsafe_get s (pos+3) = 'd' then (
                          1
                        )
                        else (
                          -1
                        )
                      )
                    | 't' -> (
                        if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'x' && String.unsafe_get s (pos+3) = 't' then (
                          4
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 5 -> (
                  if String.unsafe_get s pos = 'b' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'd' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 8 -> (
                  if String.unsafe_get s pos = 'u' && String.unsafe_get s (pos+1) = 's' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'm' && String.unsafe_get s (pos+7) = 'e' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 9 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'p' then (
                    6
                  )
                  else (
                    -1
                  )
                )
              | 11 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'h' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'a' && String.unsafe_get s (pos+5) = 'd' && String.unsafe_get s (pos+6) = '_' then (
                    match String.unsafe_get s (pos+7) with
                      | 'h' -> (
                          if String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 's' && String.unsafe_get s (pos+10) = 'h' then (
                            5
                          )
                          else (
                            -1
                          )
                        )
                      | 'n' -> (
                          if String.unsafe_get s (pos+8) = 'a' && String.unsafe_get s (pos+9) = 'm' && String.unsafe_get s (pos+10) = 'e' then (
                            3
                          )
                          else (
                            -1
                          )
                        )
                      | _ -> (
                          -1
                        )
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_board := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_kind := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_username := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_thread_name := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_text := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | 5 ->
              field_thread_hash := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x20;
            | 6 ->
              field_timestamp := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x40;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x7f then Ag_oj_run.missing_fields p [| !bits0 |] [| "board"; "kind"; "username"; "thread_name"; "text"; "thread_hash"; "timestamp" |];
        (
          {
            board = !field_board;
            kind = !field_kind;
            username = !field_username;
            thread_name = !field_thread_name;
            text = !field_text;
            thread_hash = !field_thread_hash;
            timestamp = !field_timestamp;
          }
         : transaction_data_json)
      )
)
let transaction_data_json_of_string s =
  read_transaction_data_json (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_transaction_json : _ -> transaction_json -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"data\":";
    (
      write_transaction_data_json
    )
      ob x.data;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"hash\":";
    (
      Yojson.Safe.write_string
    )
      ob x.hash;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"timestamp\":";
    (
      Yojson.Safe.write_int
    )
      ob x.timestamp;
    Bi_outbuf.add_char ob '}';
)
let string_of_transaction_json ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_transaction_json ob x;
  Bi_outbuf.contents ob
let read_transaction_json = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_data = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_hash = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_timestamp = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          match len with
            | 4 -> (
                match String.unsafe_get s pos with
                  | 'd' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'a' then (
                        0
                      )
                      else (
                        -1
                      )
                    )
                  | 'h' -> (
                      if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'h' then (
                        1
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 9 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'p' then (
                  2
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_data := (
              (
                read_transaction_data_json
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_hash := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_timestamp := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            match len with
              | 4 -> (
                  match String.unsafe_get s pos with
                    | 'd' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'a' then (
                          0
                        )
                        else (
                          -1
                        )
                      )
                    | 'h' -> (
                        if String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'h' then (
                          1
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 9 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'p' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_data := (
                (
                  read_transaction_data_json
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_hash := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_timestamp := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x7 then Ag_oj_run.missing_fields p [| !bits0 |] [| "data"; "hash"; "timestamp" |];
        (
          {
            data = !field_data;
            hash = !field_hash;
            timestamp = !field_timestamp;
          }
         : transaction_json)
      )
)
let transaction_json_of_string s =
  read_transaction_json (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__1 = (
  Ag_oj_run.write_list (
    write_transaction_json
  )
)
let string_of__1 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__1 ob x;
  Bi_outbuf.contents ob
let read__1 = (
  Ag_oj_run.read_list (
    read_transaction_json
  )
)
let _1_of_string s =
  read__1 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_block_json : _ -> block_json -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"id\":";
    (
      Yojson.Safe.write_int
    )
      ob x.id;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"prev_hash\":";
    (
      Yojson.Safe.write_string
    )
      ob x.prev_hash;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"transactions\":";
    (
      write__1
    )
      ob x.transactions;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"timestamp\":";
    (
      Yojson.Safe.write_int
    )
      ob x.timestamp;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"hash\":";
    (
      Yojson.Safe.write_string
    )
      ob x.hash;
    Bi_outbuf.add_char ob '}';
)
let string_of_block_json ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_block_json ob x;
  Bi_outbuf.contents ob
let read_block_json = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_id = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_prev_hash = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_transactions = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_timestamp = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_hash = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          match len with
            | 2 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                  0
                )
                else (
                  -1
                )
              )
            | 4 -> (
                if String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'h' then (
                  4
                )
                else (
                  -1
                )
              )
            | 9 -> (
                match String.unsafe_get s pos with
                  | 'p' -> (
                      if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'h' then (
                        1
                      )
                      else (
                        -1
                      )
                    )
                  | 't' -> (
                      if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'p' then (
                        3
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 12 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 's' then (
                  2
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_id := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_prev_hash := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | 2 ->
            field_transactions := (
              (
                read__1
              ) p lb
            );
            bits0 := !bits0 lor 0x4;
          | 3 ->
            field_timestamp := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x8;
          | 4 ->
            field_hash := (
              (
                Ag_oj_run.read_string
              ) p lb
            );
            bits0 := !bits0 lor 0x10;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            match len with
              | 2 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'd' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 4 -> (
                  if String.unsafe_get s pos = 'h' && String.unsafe_get s (pos+1) = 'a' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'h' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | 9 -> (
                  match String.unsafe_get s pos with
                    | 'p' -> (
                        if String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'e' && String.unsafe_get s (pos+3) = 'v' && String.unsafe_get s (pos+4) = '_' && String.unsafe_get s (pos+5) = 'h' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 's' && String.unsafe_get s (pos+8) = 'h' then (
                          1
                        )
                        else (
                          -1
                        )
                      )
                    | 't' -> (
                        if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'm' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 't' && String.unsafe_get s (pos+6) = 'a' && String.unsafe_get s (pos+7) = 'm' && String.unsafe_get s (pos+8) = 'p' then (
                          3
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 12 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 'a' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 's' && String.unsafe_get s (pos+5) = 'a' && String.unsafe_get s (pos+6) = 'c' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 's' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_id := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_prev_hash := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | 2 ->
              field_transactions := (
                (
                  read__1
                ) p lb
              );
              bits0 := !bits0 lor 0x4;
            | 3 ->
              field_timestamp := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x8;
            | 4 ->
              field_hash := (
                (
                  Ag_oj_run.read_string
                ) p lb
              );
              bits0 := !bits0 lor 0x10;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x1f then Ag_oj_run.missing_fields p [| !bits0 |] [| "id"; "prev_hash"; "transactions"; "timestamp"; "hash" |];
        (
          {
            id = !field_id;
            prev_hash = !field_prev_hash;
            transactions = !field_transactions;
            timestamp = !field_timestamp;
            hash = !field_hash;
          }
         : block_json)
      )
)
let block_json_of_string s =
  read_block_json (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__2 = (
  Ag_oj_run.write_list (
    write_block_json
  )
)
let string_of__2 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__2 ob x;
  Bi_outbuf.contents ob
let read__2 = (
  Ag_oj_run.read_list (
    read_block_json
  )
)
let _2_of_string s =
  read__2 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_blockchain_json : _ -> blockchain_json -> _ = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"count\":";
    (
      Yojson.Safe.write_int
    )
      ob x.count;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"blocks\":";
    (
      write__2
    )
      ob x.blocks;
    Bi_outbuf.add_char ob '}';
)
let string_of_blockchain_json ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_blockchain_json ob x;
  Bi_outbuf.contents ob
let read_blockchain_json = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let field_count = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let field_blocks = ref (Obj.magic (Sys.opaque_identity 0.0)) in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          match len with
            | 5 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 't' then (
                  0
                )
                else (
                  -1
                )
              )
            | 6 -> (
                if String.unsafe_get s pos = 'b' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'k' && String.unsafe_get s (pos+5) = 's' then (
                  1
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            field_count := (
              (
                Ag_oj_run.read_int
              ) p lb
            );
            bits0 := !bits0 lor 0x1;
          | 1 ->
            field_blocks := (
              (
                read__2
              ) p lb
            );
            bits0 := !bits0 lor 0x2;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            match len with
              | 5 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 'n' && String.unsafe_get s (pos+4) = 't' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 6 -> (
                  if String.unsafe_get s pos = 'b' && String.unsafe_get s (pos+1) = 'l' && String.unsafe_get s (pos+2) = 'o' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'k' && String.unsafe_get s (pos+5) = 's' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              field_count := (
                (
                  Ag_oj_run.read_int
                ) p lb
              );
              bits0 := !bits0 lor 0x1;
            | 1 ->
              field_blocks := (
                (
                  read__2
                ) p lb
              );
              bits0 := !bits0 lor 0x2;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x3 then Ag_oj_run.missing_fields p [| !bits0 |] [| "count"; "blocks" |];
        (
          {
            count = !field_count;
            blocks = !field_blocks;
          }
         : blockchain_json)
      )
)
let blockchain_json_of_string s =
  read_blockchain_json (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
