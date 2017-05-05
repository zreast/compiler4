#!/bin/bash
echo -e  "Auto Make+Testcase <3\n"
./out.comp < test.in
gcc -c assembly.s -o result.o
gcc result.o -o result
./result
