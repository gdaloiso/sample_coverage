#!/bin/bash

file="main.gcno"
if [ -f "$file" ]
then
	rm *.g*
	rm -rf html
	rm coverage.info
	echo "Remove *.g*, coverage.info files and html directory"
fi

gcc -fprofile-arcs -ftest-coverage -shared -fPIC -o libget.so libget.c 
gcc -Wall -O0 -fprofile-arcs -ftest-coverage main.c -L. get.c -lget 
export LD_LIBRARY_PATH=. 
./a.out && echo"COVERAGE"
#gcov  main.c get.c libget.c 
lcov --capture --directory . --output-file coverage.info > /dev/null
genhtml -o ./html coverage.info

