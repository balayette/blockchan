(*

At the moment, the whole blockchain has to fit in memory.
Later, it'll be able to be "streamed". At any point in time the
blockchain only needs to know the previous block to validate the current
block.

Could use Core's Error and Ok for error handling

Will have to check that the json data is valid at some point
*)

let greetings () =
  print_string "############################\n";
  print_string "##     BLOCKCHAN SERVER   ##\n";
  print_string "############################\n";;

(* let () = *)
(*   greetings (); *)
(*   let a = Transaction.new_transaction "First transaction" *)
(*   and b = Transaction.new_transaction "Second transaction" in *)
(*   match (a, b) with *)
(*   | (Some t1, Some t2) -> ( *)
(*       Transaction.print_transaction t1; Transaction.print_transaction t2; *)
(*       let blc = Blockchain.new_blockchain () in *)
(*       Blockchain.print_blockchain blc; *)
(*       let blo = Block.new_block (Blockchain.get_latest blc) [t1; t2] in *)
(*       Block.print_block blo; *)
(*       let blc = Blockchain.add_block blc blo in *)
(*       match blc with *)
(*       | Some x -> Blockchain.print_blockchain x *)
(*       | None -> () *)
(*     ) *)
(*   | _ -> () *)


(* let () = *)
(*   greetings (); *)
(*   let a = Transaction_data.new_transaction_data (Transaction_data.CONSUMER_TECH) (Transaction_data.NEW_THREAD) in *)
(*   let tr = Transaction.new_transaction a in *)
(*   Transaction.print_transaction tr;; *)

(* open Json_ds_t *)

(* let () = *)
(*   let str = Core.In_channel.read_all "src/blockchain.json" in *)
(*   let blc = Json_ds_j.blockchain_json_of_string str in *)
(*   let acblc = Blockchain.blockchain_of_json_ds blc in *)
(*   Blockchain.print_blockchain acblc; *)
(*   let nacblc = Blockchain.json_ds_of_blockchain acblc in *)
(*   let ser = Json_ds_j.string_of_blockchain_json nacblc in *)
(*   print_string ser; *)
