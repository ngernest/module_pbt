(* Code from Real World OCaml, Chapter 11 *)
type 'a t
include (module type of Fqueue) with type 'a t := 'a t
include Foldable.Extension with type 'a t := 'a t