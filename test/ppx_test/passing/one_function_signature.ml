module type S = sig
  type 'a t

  val f : 'a t -> 'a t
end
[@@deriving_inline mica_types]

type expr = F of expr
type ty = IntT

let rec gen_expr ty = failwith "TODO"
let _ = gen_expr
[@@@end]
