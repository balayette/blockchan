(*

At the moment, the whole blockchain has to fit in memory.
Later, it'll be able to be "streamed". At any point in time the
blockchain only needs to know the previous block to validate the current
block.

Could use Core's Error and Ok for error handling
*)

let greetings () =
  print_string "############################\n";
  print_string "##     BLOCKCHAN SERVER   ##\n";
  print_string "############################\n";;

let () =
  greetings ();
  let a = Transaction.new_transaction "First transaction"
  and b = Transaction.new_transaction "Second transaction" in
  match (a, b) with
  | (Some t1, Some t2) -> (
      Transaction.print_transaction t1; Transaction.print_transaction t2;
      let blc = Blockchain.new_blockchain () in
      Blockchain.print_blockchain blc;
      let blo = Block.new_block (List.hd (Blockchain.get_blocks blc)) [t1; t2] in
      Block.print_block blo;
      let blc = Blockchain.add_block blc blo in
      match blc with
      | Some x -> Blockchain.print_blockchain x
      | None -> ()
    )
  | _ -> ()
