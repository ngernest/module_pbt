open Ppxlib
open Ast_builder.Default
open Lident
open Printers
open StdLabels
open Miscellany

(* TODO: module that contain functions for generating fresh names *)

(** [ppat_var_of_string x ~loc] creates the pattern [Ppat_var x] 
            at location [loc] *)
let ppat_var_of_string (x : string) ~(loc : Location.t) : pattern =
  ppat_var ~loc (with_loc x ~loc)

(** Turns the variable [x] into [x'] *)
let add_prime : string -> string = fun x -> x ^ "\'"

(** A more elaborate version of [add_prime] which does the same thing,
    but uses [Ppxlib]'s in-built [quoter]
    - Note: this function is currently unused
    - TODO: the quoter ought to be created by the caller, methinks *)
let quote_name (name : string) : string =
  let open Expansion_helpers.Quoter in
  let quoter = create () in
  let new_name = quote quoter (evar ~loc:Location.none name) in
  match new_name.pexp_desc with
  | Pexp_ident { txt = quoted_name; _ } -> string_of_lident quoted_name
  | _ -> failwith "impossible"

(** Produces a fresh variable at location [loc], with the type [ty]
    of the variable serialized & prefixed to the resultant variable name *)
let mk_fresh_ppat_var ~(loc : Location.t) (ty : core_type) : pattern =
  let prefix = uncapitalize (string_of_core_ty ty) in
  gen_symbol ~prefix () |> ppat_var_of_string ~loc

(** [mk_fresh_legacy ~loc i ty] generates a fresh variable at location [loc] 
    that corresponds to the type [ty], with the (integer) index [i + 1] 
    used as a varname suffix 
    - We add 1 to [i] so that variable names are 1-indexed 
    - Note: this function has now been deprecated in favor of [mk_fresh_ppat_var],
      which uses [Ppxlib]'s official [gen_symbol] function for producing
      fresh variable names
    - Note: this function is not exposed in [names.mli] to avoid 
      clients of this module from using this function *)
let rec mk_fresh_legacy ~(loc : Location.t) (i : int) (ty : core_type) : pattern
    =
  let varname =
    match ty with
    | [%type: bool] -> "b"
    | [%type: char] -> "c"
    | [%type: string] -> "s"
    | [%type: unit] -> "u"
    | [%type: int] | [%type: 'a] -> "x"
    | [%type: expr] | [%type: t] | [%type: 'a t] -> "e"
    | { ptyp_desc; _ } -> (
      match ptyp_desc with
      | Ptyp_tuple _ -> "p"
      | Ptyp_arrow _ -> "f"
      | Ptyp_constr ({ txt; _ }, _) ->
        let tyconstr = string_of_lident txt in
        if String.equal tyconstr "list" then "lst"
          (* For unrecognized type constructors, just extract the first char of
             the type constructor's name *)
        else String.sub tyconstr ~pos:0 ~len:1
      | _ ->
        pp_core_type ty;
        failwith "TODO: [mk_fresh] not supported for types of this shape") in
  ppat_var ~loc (with_loc ~loc (varname ^ Int.to_string (i + 1)))

(** Produces fresh variable names corresponding to a value [arg] of type 
    [constructor_arguments] at location [loc] *)
let varnames_of_cstr_args ~(loc : Location.t) (arg : constructor_arguments) :
  pattern list =
  match arg with
  | Pcstr_tuple tys -> List.map ~f:(mk_fresh_ppat_var ~loc) tys
  | Pcstr_record lbl_decls ->
    List.map lbl_decls ~f:(fun { pld_name; pld_type; pld_loc; _ } ->
        gen_symbol ~prefix:pld_name.txt () |> ppat_var_of_string ~loc:pld_loc)

(** Takes a [constructor_declaration] and produces the pattern 
    [Ppat_construct] *)
let ppat_construct_of_cstr_decl ~(loc : Location.t)
  (cstr_decl : constructor_declaration) : pattern =
  let cstr_name : Longident.t loc =
    map_with_loc ~f:Longident.parse cstr_decl.pcd_name in
  (* Generate fresh names for the construct arguments, then convert them to the
     [Ppat_tuple] pattern *)
  let arg_names : pattern list = varnames_of_cstr_args ~loc cstr_decl.pcd_args in
  let cstr_args : pattern option = ppat_tuple_opt ~loc arg_names in
  ppat_construct ~loc cstr_name cstr_args

(** [update_expr_arg_names expr_args args] replaces each variable [x] in 
    [expr_args] if [x'] (the variable with a prime added) is in [expr_args] *)
let update_expr_arg_names (expr_args : string list) (args : string list) :
  string list =
  List.map args ~f:(fun x ->
      if List.mem (add_prime x) ~set:expr_args then add_prime x else x)
