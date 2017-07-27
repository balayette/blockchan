module List =
    struct
        include List
        let repr_of_hashes l =
            let rec aux l acc = match l with
            | e::[] -> acc ^ e
            | e::l -> aux l (acc ^ e ^ ", ")
            | [] -> acc
            in aux l ""

        let remove_options l =
          let rec aux l acc = match l with
            | [] -> acc
            | e::l -> (
                match e with
                | None -> aux l acc
                | Some x -> aux l (x::acc)
              )
          in List.rev (aux l [])
    end
