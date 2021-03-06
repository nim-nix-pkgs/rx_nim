{
  description = ''An implementation of rx observables in nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."rx_nim-master".dir   = "master";
  inputs."rx_nim-master".owner = "nim-nix-pkgs";
  inputs."rx_nim-master".ref   = "master";
  inputs."rx_nim-master".repo  = "rx_nim";
  inputs."rx_nim-master".type  = "github";
  inputs."rx_nim-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."rx_nim-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}