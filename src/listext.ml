module List =
    struct
        include List
        let repr_of_hashes l =
            let rec aux l acc = match l with
            | e::[] -> acc ^ e
            | e::l -> aux l (acc ^ e ^ ", ")
            | [] -> acc
            in aux l ""
    end
