let hash_data data = Digestif.SHA256.Bytes.digest data |> Digestif.SHA256.Bytes.to_hex
let transaction_hash = hash_data

let block_hash timestamp hashes id =
  let rec concat_hashes l acc = match l with
    | e::l -> concat_hashes l (acc ^  e)
    | [] -> acc
   in (string_of_int timestamp) ^ (concat_hashes hashes "") ^ (string_of_int id) |> hash_data
