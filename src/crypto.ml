let hash_data data = Digestif.SHA256.Bytes.digest data |> Digestif.SHA256.Bytes.to_hex

let transaction_hash data =
  let open Transaction_data in
  let board_s = (get_board data) |> string_of_board
  and kind_s = (get_kind data) |> string_of_transaction_type
  and username_s = (get_username data)
  and thread_name_s = (get_thread_name data)
  and text_s = (get_text data)
  and t_hash_s = (get_thread_hash data) in
  String.concat board_s [kind_s;
                         username_s;
                         thread_name_s;
                         thread_name_s;
                         text_s;
                         t_hash_s] |> hash_data

let block_hash timestamp hashes id =
  let rec concat_hashes l acc = match l with
    | e::l -> concat_hashes l (acc ^  e)
    | [] -> acc
   in (string_of_int timestamp) ^ (concat_hashes hashes "") ^ (string_of_int id) |> hash_data


let thread_hash data =
  let open Transaction_data in
  let board = (get_board t_data) |> string_of_board
  and username = get_username t_data
  and thread_name = get_thread_name t_data
  and text = get_text t_data
  and timestamp = get_timestamp t_data in
  String.concat board [username;
                       thread_name;
                       text;
                       timestamp;] |> hash_data
