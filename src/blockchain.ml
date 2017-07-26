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
  if (Block.get_hash last_block) <> (Block.get_previous_hash b) then (
    Printf.printf "The block with hash %s doesn't match the previous block : expected prev_hash = %s, got prev_hash = %s\n" (Block.get_hash b) (Block.get_hash last_block) (Block.get_previous_hash b); None
  )
  else (
    if (Block.get_id b) <> (Block.get_id last_block) + 1 then (
      Printf.printf "The block with hash %s doesn't match the previous block : expected id = %d, got id = %d" (Block.get_hash b) ((Block.get_id last_block) + 1) (Block.get_id b); None
    )
    else (
      let actual_hash = Block.block_hash (Block.get_timestamp b) (Block.get_transactions b) (Block.get_id b) in
      if actual_hash <> (Block.get_hash b) then (
        Printf.printf "The block has hash %s, expected %s" (Block.get_hash b) actual_hash; None
      )
      else (
        Printf.printf "The block with hash %s is valid, adding it to the blockchain\n" (Block.get_hash b);
        Some {count = bl.count + 1; blocks = b::bl.blocks}
      )
    )
  )
