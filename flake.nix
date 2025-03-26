{
  description = "oxilite";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs =
    inputs@{ nixpkgs, self, ... }:
    let
      packagesFor = system: rec {
        default = oxilite;
        oxilite = nixpkgs.legacyPackages.${system}.callPackage ./nix/package.nix { };
      };
      appsFor = system: rec {
        default = oxilite;
        oxilite = {
          type = "app";
          program = "${self.outputs.packages.${system}.oxilite}/bin/sparqlite";
        };
      };
    in
    {
      packages.x86_64-linux = packagesFor "x86_64-linux";

      apps.x86_64-linux = appsFor "x86_64-linux";

      overlays.default = final: _: {
        oxilite = final.callPackage ./nix/package.nix { };
      };
    };
}
