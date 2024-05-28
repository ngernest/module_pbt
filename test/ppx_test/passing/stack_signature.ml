module type StackInterface = sig
  type 'a t

  val empty : 'a t
  val push : 'a -> 'a t -> 'a t
  val pop : 'a t -> 'a t option
  val peek : 'a t -> 'a option
  val clear : 'a t -> unit
  val is_empty : 'a t -> bool
  val length : 'a t -> int
end
[@@deriving_inline mica_types, mica]

include
  struct
    [@@@ocaml.warning "-60"]
    type expr =
      | Empty
      | Push of int * expr
      | Pop of expr
      | Peek of expr
      | Clear of expr
      | Is_empty of expr
      | Length of expr
    type ty =
      | Bool
      | Int
      | IntOption
      | IntT
      | IntTOption
      | Unit
    module TestHarness(M:StackInterface) =
      struct
        include M
        type value =
          | ValBool of bool
          | ValInt of int
          | ValIntOption of int option
          | ValIntT of int t
          | ValIntTOption of int t option
          | ValUnit of unit
        let rec interp e =
          match e with
          | Empty -> ValIntT M.empty
          | Push (x1, e2) ->
              (match interp e2 with
               | ValIntT e2' -> ValIntT (M.push x1 e2')
               | _ -> failwith "impossible")
          | Pop e1 ->
              (match interp e1 with
               | ValIntT e1' -> ValIntTOption (M.pop e1')
               | _ -> failwith "impossible")
          | Peek e1 ->
              (match interp e1 with
               | ValIntT e1' -> ValIntOption (M.peek e1')
               | _ -> failwith "impossible")
          | Clear e1 ->
              (match interp e1 with
               | ValIntT e1' -> ValUnit (M.clear e1')
               | _ -> failwith "impossible")
          | Is_empty e1 ->
              (match interp e1 with
               | ValIntT e1' -> ValBool (M.is_empty e1')
               | _ -> failwith "impossible")
          | Length e1 ->
              (match interp e1 with
               | ValIntT e1' -> ValInt (M.length e1')
               | _ -> failwith "impossible")
        let _ = interp
      end
  end[@@ocaml.doc "@inline"]
[@@@end]
