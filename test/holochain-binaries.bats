#!/usr/bin/env bats

@test "expected holochain version available" {
  result="$(holochain --version)"
  echo $result
  [[ "$result" == *" 0.0.103" ]]
}

@test "expected hc version available" {
  result="$(hc --version)"
  echo $result
  [[ "$result" == *" 0.0.4" ]]
}

@test "expected lair-keystore version available" {
  result="$(lair-keystore --version)"
  echo $result
  [[ "$result" == *" 0.0.3" ]]
}

@test "expected kitsune-p2p-proxy version available" {
  result="$(kitsune-p2p-proxy --version)"
  echo $result
  [[ "$result" == *" 0.0.3" ]]
}
