{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    gitignore.url = "github:hercules-ci/gitignore.nix";
  };
  outputs = {...} @ inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = (import inputs.nixpkgs) {
          inherit system;
          config = {
            # allowUnfree = true;
            # allowBroken = true;
          };
        };
      in {
        devShells = rec {
          py = pkgs.mkShell {
            packages = with pkgs; [
              imagemagick
              python3Full
              envsubst
            ];
          };
          default = py;
        };
        formatter = let
          treefmtconfig = inputs.treefmt-nix.lib.evalModule pkgs {
            projectRootFile = "flake.nix";
            programs = {
              toml-sort.enable = true;
              yamlfmt.enable = true;
              mdformat.enable = true;
              prettier.enable = true;
              shellcheck.enable = true;
              shfmt.enable = true;
            };
            settings.formatter.shellcheck.excludes = [".envrc"];
          };
        in
          treefmtconfig.config.build.wrapper;
        apps = rec {
        };
        packages = rec {
          branding = pkgs.callPackage ./build.nix { };
          deploy = pkgs.callPackage ./deploy.nix { src = branding; };
          default = branding;
        };
      }
    );
}
