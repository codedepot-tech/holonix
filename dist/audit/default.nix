{
 pkgs,
 dist,
 rust,
 cli,
 conductor,
 lib,
}:
let
  name = "hc-dist-audit";

  script = pkgs.writeShellScriptBin name
  ''
  echo
  echo "All the important dist vars:"
  echo

  echo "Binary version is ${dist.version}"

  echo

  echo "CLI linux hash is ${cli.sha256.linux}"
  echo "CLI darwin hash is ${cli.sha256.darwin}"

  echo

  echo "Conductor linux hash is ${conductor.sha256.linux}"
  echo "Conductor darwin hash is ${conductor.sha256.darwin}"

  echo
  echo "All the prefetching:"
  echo

  echo "CLI linux prefetch:"
  nix-prefetch-url ${lib.artifact-url { name = cli.name; target = ( lib.normalize-artifact-target rust.generic-linux-target ); }}
  echo

  echo "CLI darwin prefetch:"
  nix-prefetch-url ${lib.artifact-url { name = cli.name; target = ( lib.normalize-artifact-target rust.generic-mac-target ); }}
  echo

  echo "Conductor linux prefetch:"
  nix-prefetch-url ${lib.artifact-url { name = conductor.name; target = ( lib.normalize-artifact-target rust.generic-linux-target ); }}
  echo

  echo "Conductor darwin prefetch:"
  nix-prefetch-url ${lib.artifact-url { name = conductor.name; target = ( lib.normalize-artifact-target rust.generic-mac-target ); }}
  echo
  '';
in
{
 buildInputs = [ script ];
}
