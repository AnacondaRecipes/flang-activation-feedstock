#!/bin/bash
# FC is set by the activation script
set -euxo pipefail

$FC hello_world.f90
./a.out

# since LLVM 23 the intrinsic modules come from flang-rt;
# compile, link and run a program using them through the activated compiler
$FC test_modules.f90 -o test_modules
./test_modules
