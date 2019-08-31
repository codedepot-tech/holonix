final: previous:

with final;

{
  github-release =
    haskell.lib.justStaticExecutables previous.haskellPackages.github-release;

  holochain = {
    hc = lib.warn "holochain.hc is deprecated, use holochain-cli" holochain-cli;
    holochain = lib.warn "holochain.holochain is deprecated, use holochain-conductor" holochain-conductor;
  };

  hn-node-flush = writeShellScriptBin "hn-node-flush" ''
    echo "flushing node artifacts"
    find . -wholename "**/node_modules" | xargs -I {} rm -rf {};
  '';

  hn-rust-clippy = writeShellScriptBin "hn-rust-clippy" ''
    echo "submitting to the wrath of clippy"
    cargo clippy -- \
      -A clippy::nursery -A clippy::style -A clippy::cargo \
      -A clippy::pedantic -A clippy::restriction \
      -D clippy::complexity -D clippy::perf -D clippy::correctness
  '';

  hn-rust-flush = writeShellScriptBin "hn-rust-flush" ''
    echo "flushing cargo cache from user home directory"
    rm -rf ~/.cargo/registry;
    rm -rf ~/.cargo/git;

    echo "flushing cargo artifacts and cache from project directories"
    find . -wholename "**/.cargo" | xargs -I {} rm -rf {};
    find . -wholename "**/target" | xargs -I {} rm -rf {};

    echo "flushing cargo lock files"
    find . -name "Cargo.lock" | xargs -I {} rm {};

    echo "flushing binary artifacts from dist"
    rm -rf ./dist;
  '';
}
