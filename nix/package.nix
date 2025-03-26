{
  cargo,
  clangStdenv,
  lib,
  libclang,
  makeRustPlatform,
  rustc,
}:

let
  rustPlatform = makeRustPlatform {
    inherit cargo rustc;
    stdenv = clangStdenv;
  };
in
rustPlatform.buildRustPackage {
  name = "oxilite";
  src = lib.cleanSource ./..;
  useFetchCargoVendor = true;
  cargoHash = "sha256-OipJdvpisHMyYQdcb2PkqcbWz4XIWJO8foY72hsgNzc=";
  LIBCLANG_PATH = "${libclang.lib}/lib";
}
