#!/bin/bash
echo -e  "<3 Auto Testcase Injector :\n"
./out.comp < test.in
gcc -c assembly.s -o result.o
gcc result.o -o result
./result
