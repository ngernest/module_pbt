(** Module signature for the Elliptic-Curve Diffie-Hellman (ECDH) 
    key exchange protocol *)
module type ECDHIntf = sig 
  (** Abstract type for public keys *)
  type public_key [@@deriving sexp_of]

  (** Abstract type for private keys *)
  type private_key [@@deriving sexp_of]

  (** The base point [G] of the elliptic curve, 
      also the generator of the cyclic subgroup for ECDH *)
  val base : public_key

  val public_key_of_string: string -> public_key
  val private_key_of_string: string -> private_key

  val string_of_public_key: public_key -> string
  val string_of_private_key: private_key -> string

  val public_key_of_private_key: private_key -> public_key


  (* [scalar_mult a G] computes the scalar multiplication [aG], where 
     [G] is the generator of the cyclic subgroup 
     (i.e. [G] is the base point on the elliptic curve), and [a] is some integer 
     - In Callipgyge, this is called [ecdh_inplace]
  *)
  val scalar_mult : private_key -> public_key -> public_key

  (** Computes the shared key as a string *)
  val x25519_ecdh : private_key -> public_key -> string 
end   