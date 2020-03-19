open Lwt.Infix

module Main (RES : Resolver_lwt.S) (CON : Conduit_mirage.S) = struct
  module Mem_store = Irmin_mirage_git.Mem.KV (Irmin.Contents.String)
  module Sync = Irmin.Sync (Mem_store)

  let uri_str = "https://github.com/samoht/mirmin.git"

  let start resolver conduit =
    (* Create a new in-memory repository *)
    Irmin_mem.config () |> Mem_store.Repo.v
    (* Select store master *)
    >>= Mem_store.master
    (* Synchronize with remote *)
    >>= fun store ->
    let remote = Mem_store.remote ~conduit ~resolver uri_str in
    Sync.pull_exn ~depth:1 store remote `Set
    (* Print content of README.md from store master *)
    >>= fun _ ->
    Mem_store.get store [ "README.md" ] >|= fun res ->
    Logs.info (fun f -> f "\n%s\n" res)
end
