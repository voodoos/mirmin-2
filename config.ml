open Mirage

let disk = direct_kv_rw "t"

let main =
  foreign
    ~packages:[ package "irmin"; package "irmin-mirage-git" ]
    "Unikernel.Main"
    (resolver @-> conduit @-> job)

let () =
  let stack = generic_stackv4 default_network in
  let res_dns = resolver_dns stack in
  let conduit = conduit_direct ~tls:true stack in
  register "kv_ro" [ main $ res_dns $ conduit ]
