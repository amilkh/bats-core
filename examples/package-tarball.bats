#!/usr/bin/env bats

# test_dir is where all temporary files created for running the test live
TEST_DIR="test_dir"

setup() {
  mkdir "${TEST_DIR}"
  cd "${TEST_DIR}"

  export dst_tarball='dst.tar.gz'
  export src_dir='src_dir'

  mkdir "${src_dir}"
  touch "${src_dir}/"{a,b,c}
}

teardown() {
  cd ..
  rm -rf "${TEST_DIR}"
}

main() {
  ../package-tarball
}

@test 'it fails if any variables are unbound' {
  unset src_root dst_tarball

  run main
  [ "${status}" -ne 0 ]
}

@test 'it fails when src_dir is a non-existent directory' {
  export src_dir='not-a-dir'

  run main
  [ "${status}" -ne 0 ]
}

@test 'it works when src_dir is empty' {
  rm -rf "${src_dir}/*"

  run main
  echo $output
  [ "${status}" -eq 0 ]
}

@test 'it properly tars files in src_root/' {
  run main
  [ "${status}" -eq 0 ]

  run tar tf "$dst_tarball"
  [ "${status}" -eq 0 ]
  [[ "${output}" =~ 'a' ]]
  [[ "${output}" =~ 'b' ]]
  [[ "${output}" =~ 'c' ]]
}
