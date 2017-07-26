open Listext

type t =
  { count : int;
    blocks : Block.t list;
  }

let get_blocks bl = bl.blocks

let get_count bl = bl.count

let print_blockchain bl =
  Printf.printf "BLOCKCHAIN :\ncount : %d\nblocks : %s\n*************\n\n\n\n"
    (get_count bl)
    (List.repr_of_hashes (List.map (fun b -> Block.get_hash b) (get_blocks bl)))

let new_blockchain () =
  let count = 1 in
  let genesis = Block.genesis_block () in
  print_string "Genesis block : \n";
  Block.print_block genesis;
  {count = count; blocks = [genesis]}

(* TODO : Actual error handling *)
let add_block bl b =
  let last_block = List.hd (get_blocks bl) in
  let last_hash = (Block.get_hash last_block)
  and curr_hash = (Block.get_hash b)
  and prev_hash = (Block.get_previous_hash b)
  and curr_id = (Block.get_id b)
  and last_id = (Block.get_id last_block) in
  if last_hash <> prev_hash then (
    Printf.printf "The block with hash %s doesn't match the previous block : expected prev_hash = %s, got prev_hash = %s\n" curr_hash last_hash prev_hash; None
  )
  else (
    if curr_id <> last_id + 1 then (
      Printf.printf "The block with hash %s doesn't match the previous block : expected id = %d, got id = %d" curr_hash (last_id + 1) curr_id; None
    )
    else (
      let actual_hash = Block.block_hash (Block.get_timestamp b) (Block.get_transactions b) curr_id in
      if actual_hash <> curr_hash then (
        Printf.printf "The block has hash %s, expected %s" curr_hash actual_hash; None
      )
      else (
        Printf.printf "The block with hash %s is valid, adding it to the blockchain\n" curr_hash;
        Some {count = bl.count + 1; blocks = b::bl.blocks}
      )
    )
  )

let get_latest bl = List.hd (get_blocks bl)
