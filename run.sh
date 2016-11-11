#!/bin/sh

#execute the test runner and capture the status code
echo "Running: http://127.0.0.1:8123$TEST_RUNNER_URI"
http_code=$(curl -s -o /tmp/result.txt -w '%{http_code}' http://127.0.0.1:8123$TEST_RUNNER_URI;)
echo "Finished with Status: $http_code"
#output the result
cat /tmp/result.txt
if [[ $http_code -eq 200 ]]; then
    exit 0
fi

#fail if status code is not 200
exit 1
