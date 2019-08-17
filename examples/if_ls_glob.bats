#!/usr/bin/env bats

# test_dir is where all temporary files created for running the test live
TEST_DIR="test_dir"

setup() {
  mkdir "${TEST_DIR}"
  cd "${TEST_DIR}"

  echo() {
    true
  }
}

teardown() {
  cd ..
  rm -rf "${TEST_DIR}"
}

main() {
  if ls *.txt >/dev/null 2>&1; then
    echo *.txt
  fi
}

@test 'it works when there are no .txt files' {
  run main
  [ "${status}" -eq 0 ]
}

@test 'it works when there is one .txt file' {
  touch a.txt

  run main
  [ "${status}" -eq 0 ]
}

@test 'it works when there are two .txt file' {
  touch {a,b}.txt

  run main
  [ "${status}" -eq 0 ]
}

@test 'it works when there are three .txt file' {
  touch {a,b,c}.txt

  run main
  [ "${status}" -eq 0 ]
}
