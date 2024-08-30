open Base
open Base_quickcheck
open Charsets
open Generator
module M1 = Stdlib_Charset
module M2 = Yallop_Charset

(* type func = { f : (char -> char) [@sexp.opaque]; pairs : (char * char) list;
   default : char } [@@deriving sexp_of] *)

type expr =
  (* T *)
  | Empty
  | Add of char * expr
  | Remove of char * expr
  | Union of expr * expr
  | Inter of expr * expr
  | Diff of expr * expr
  (* Bool *)
  | Disjoint of expr * expr
  | Is_empty of expr
  (* Int *)
  | Cardinal of expr
  (* CharList *)
  | Elements of expr
  (* Char *)
  | Min_elt of expr
  | Max_elt of expr
  | Choose of expr
  (* CharOption *)
  | Min_elt_opt of expr
  | Max_elt_opt of expr
  | Choose_opt of expr
[@@deriving sexp_of]

type ty = Char | Bool | Int | CharOption | CharList | T

let mk_fun (pairs : (char * char) list) ~(default : char) : char -> char =
  match pairs with
  | [] -> failwith "expected non-empty list"
  | _ ->
    fun x ->
      let y = List.Assoc.find pairs ~equal:Char.equal x in
      Option.value y ~default

let rec gen_expr (ty : ty) : expr Generator.t =
  let open Let_syntax in
  let%bind k = size in
  match (ty, k) with
  | T, 0 -> return Empty
  | Int, _ ->
    let%bind e = with_size ~size:(k / 2) (gen_expr T) in
    return @@ Cardinal e
  | Bool, _ ->
    let gen_disjoint =
      let%bind e1 = with_size ~size:(k / 2) (gen_expr T) in
      let%bind e2 = with_size ~size:(k / 2) (gen_expr T) in
      return (Disjoint (e1, e2)) in
    let gen_is_empty =
      let%bind e = with_size ~size:(k / 2) (gen_expr T) in
      return (Is_empty e) in
    union [ gen_disjoint; gen_is_empty ]
  | CharList, _ ->
    let%bind e = with_size ~size:(k / 2) (gen_expr T) in
    return @@ Elements e
  | Char, _ ->
    let%bind e = with_size ~size:(k / 2) (gen_expr T) in
    union [ return (Min_elt e); return (Choose e); return (Max_elt e) ]
  | CharOption, _ ->
    let%bind e = with_size ~size:(k / 2) (gen_expr T) in
    union [ return (Min_elt_opt e); return (Max_elt_opt e) ]
  | T, _ ->
    let gen_add =
      let%bind x1 = char_alpha in
      let%bind e2 = with_size ~size:(k / 2) (gen_expr T) in
      return @@ Add (x1, e2) in
    let gen_remove =
      let%bind x1 = char_alpha in
      let%bind e2 = with_size ~size:(k / 2) (gen_expr T) in
      return @@ Remove (x1, e2) in
    let gen_union =
      let%bind e1 = with_size ~size:(k / 2) (gen_expr T) in
      let%bind e2 = with_size ~size:(k / 2) (gen_expr T) in
      return @@ Union (e1, e2) in
    let gen_inter =
      let%bind e1 = with_size ~size:(k / 2) (gen_expr T) in
      let%bind e2 = with_size ~size:(k / 2) (gen_expr T) in
      return @@ Inter (e1, e2) in
    union [ gen_add; gen_remove; gen_union; gen_inter ]

module Interpret (M : CharsetSig) = struct
  type value =
    | ValChar of char
    | ValBool of bool
    | ValInt of int
    | ValCharOption of char option
    | ValCharList of char list
    | ValT of M.t

  let rec interp (expr : expr) : value =
    match expr with
    | Empty -> ValT M.empty
    | Add (c, e) -> (
      match interp e with
      | ValT s -> ValT (M.add c s)
      | _ -> failwith "impossible")
    | Remove (c, e) -> (
      match interp e with
      | ValT s -> ValT (M.remove c s)
      | _ -> failwith "impossible")
    | Union (e1, e2) -> (
      match (interp e1, interp e2) with
      | ValT s1, ValT s2 -> ValT (M.union s1 s2)
      | _ -> failwith "impossible")
    | Inter (e1, e2) -> (
      match (interp e1, interp e2) with
      | ValT s1, ValT s2 -> ValT (M.inter s1 s2)
      | _ -> failwith "impossible")
    | Diff (e1, e2) -> (
      match (interp e1, interp e2) with
      | ValT s1, ValT s2 -> ValT (M.diff s1 s2)
      | _ -> failwith "impossible")
    | Disjoint (e1, e2) -> (
      match (interp e1, interp e2) with
      | ValT s1, ValT s2 -> ValBool (M.disjoint s1 s2)
      | _ -> failwith "impossible")
    | Is_empty e -> (
      match interp e with
      | ValT s -> ValBool (M.is_empty s)
      | _ -> failwith "impossible")
    | Cardinal e -> (
      match interp e with
      | ValT s -> ValInt (M.cardinal s)
      | _ -> failwith "impossible")
    | Elements e -> (
      match interp e with
      | ValT s -> ValCharList (M.elements s)
      | _ -> failwith "impossible")
    | Min_elt e -> (
      match interp e with
      | ValT s -> ValChar (M.min_elt s)
      | _ -> failwith "impossible")
    | Min_elt_opt e -> (
      match interp e with
      | ValT s -> ValCharOption (M.min_elt_opt s)
      | _ -> failwith "impossible")
    | Max_elt e -> (
      match interp e with
      | ValT s -> ValChar (M.max_elt s)
      | _ -> failwith "impossible")
    | Max_elt_opt e -> (
      match interp e with
      | ValT s -> ValCharOption (M.max_elt_opt s)
      | _ -> failwith "impossible")
    | Choose e -> (
      match interp e with
      | ValT s -> ValChar (M.choose s)
      | _ -> failwith "impossible")
    | Choose_opt e -> (
      match interp e with
      | ValT s -> ValCharOption (M.choose_opt s)
      | _ -> failwith "impossible")
end

module I1 = MakeHarness (M1)
module I2 = MakeHarness (M2)
