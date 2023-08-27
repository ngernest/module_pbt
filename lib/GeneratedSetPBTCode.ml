(** Generated property-based testing code *)
open! Base
open! Base_quickcheck
open SetInterface
open ListSet
open BSTSet

(* NB: the [EInt] variant is currently not produced by Mica *)
type expr =
  Empty
   | EInt of int   
   | Is_empty of expr
   | Mem of int * expr
   | Add of int * expr
   | Rem of int * expr
   | Size of expr
   | Union of expr * expr
   | Intersect of expr * expr
   | Invariant of expr
    [@@deriving sexp, compare, hash]

type ty =
  Bool | Int | T
    [@@deriving sexp]

module ExprToImpl (M : SetInterface) = struct 
  include M
  type value = 
    ValBool of bool | ValInt of int | ValT of int M.t
      [@@deriving sexp, equal]

  let rec interp (expr : expr) : value = 
    match expr with
     | Empty ->  ValT (M.empty)
     | EInt n -> ValInt n
     | Is_empty e ->
      begin match interp e with 
       | ValT e' ->  ValBool (M.is_empty e')
       | _ -> failwith "impossible"
      end
     | Mem(x1, e2) ->
      begin match interp e2 with 
       | ValT e' ->  ValBool (M.mem x1 e')
       | _ -> failwith "impossible"
      end
     | Add(x1, e2) ->
      begin match interp e2 with 
       | ValT e' ->  ValT (M.add x1 e')
       | _ -> failwith "impossible"
      end
     | Rem(x1, e2) ->
      begin match interp e2 with 
       | ValT e' ->  ValT (M.rem x1 e')
       | _ -> failwith "impossible"
      end
     | Size e ->
      begin match interp e with 
       | ValT e' ->  ValInt (M.size e')
       | _ -> failwith "impossible"
      end
     | Union(e1, e2) ->
      begin match (interp e1, interp e2) with 
       | (ValT e1', ValT e2') ->  ValT (M.union e1' e2')
       | _ -> failwith "impossible"
      end
     | Intersect(e1, e2) ->
      begin match (interp e1, interp e2) with 
       | (ValT e1', ValT e2') ->  ValT (M.intersect e1' e2')
       | _ -> failwith "impossible"
      end
     | Invariant e ->
      begin match interp e with 
       | ValT e' ->  ValBool (M.invariant e')
       | _ -> failwith "impossible"
      end

  end

let rec gen_expr (ty : ty) : expr Generator.t = 
  let module G = Generator in 
  let open G.Let_syntax in 
  let%bind k = G.size in 
  match ty, k with 
   | (T, 0) -> return Empty
   | (Bool, _) ->
      let is_empty = 
        let%bind e = G.with_size ~size:(k / 2) (gen_expr T) in 
        G.return @@ Is_empty e in 
      let mem = 
        let%bind x1 = G.int_inclusive (-10) 10 in 
        let%bind e2 = G.with_size ~size:(k / 2) (gen_expr T) in 
        G.return @@ Mem(x1, e2) in 
      let invariant = 
        let%bind e = G.with_size ~size:(k / 2) (gen_expr T) in 
        G.return @@ Invariant e
      in G.union [ is_empty; mem; invariant ]
   | (Int, _) ->
      let size = 
        let%bind e = G.with_size ~size:(k / 2) (gen_expr T) in 
        G.return @@ Size e in
      let eint = 
        let%bind n = G.int_inclusive (-10) 10 in 
        G.return @@ EInt n in
      G.union [ size; eint ]
    | (T, _) ->
      let add = 
        let%bind x1 = G.int_inclusive (-10) 10 in 
        let%bind e2 = G.with_size ~size:(k / 2) (gen_expr T) in 
        G.return @@ Add(x1, e2) in 
      let rem = 
        let%bind x1 = G.int_inclusive (-10) 10 in 
        let%bind e2 = G.with_size ~size:(k / 2) (gen_expr T) in 
        G.return @@ Rem(x1, e2) in 
      let union = 
        let%bind e1 = G.with_size ~size:(k / 2) (gen_expr T) in 
        let%bind e2 = G.with_size ~size:(k / 2) (gen_expr T) in 
        G.return @@ Union(e1, e2) in 
      let intersect = 
        let%bind e1 = G.with_size ~size:(k / 2) (gen_expr T) in 
        let%bind e2 = G.with_size ~size:(k / 2) (gen_expr T) in 
        G.return @@ Intersect(e1, e2)
      in G.union [ add; rem; union; intersect ]
   

module I1 = ExprToImpl(ListSet)
module I2 = ExprToImpl(BSTSet)

let displayError (e : expr) (v1 : I1.value) (v2 : I2.value) : string = 
  Printf.sprintf "Error: Generated [expr] was %s, Module 1 produced %s, 
  Module 2 produced %s"
    (Sexp.to_string @@ sexp_of_expr e)
    (Sexp.to_string @@ [%sexp_of: I1.value] v1)
    (Sexp.to_string @@ [%sexp_of: I2.value] v2)