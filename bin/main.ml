open! Lib.SetTypes
open! Core

(* let () = print_endline "hello" *)

(* 
let () =
  Core.Quickcheck.test (gen_expr Bool) ~f:(fun e ->
      match (I1.interp e, I2.interp e) with
      | ValBool b1, ValBool b2 -> [%test_eq: bool] b1 b2
      | _, _ -> ()) *)

let () =
  Core.Quickcheck.test (gen_expr Int) ~f:(fun e ->
    match (I1.interp e, I2.interp e) with
    | ValInt n1, ValInt n2 -> 
      (* Printf.printf "n1 = %d, n2 = %d \n" n1 n2; *)
      [%test_eq: int] n1 n2
    | _, _ -> ())      