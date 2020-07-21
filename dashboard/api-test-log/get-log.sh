#!/bin/bash -ue
# A script can be used to extract Ceph API test logs

BUILD_ID=$1
JOB_URL="https://jenkins.ceph.com/view/mgr-dashboard/job/ceph-dashboard-pr-backend"
BUILD_URL="${JOB_URL}/${BUILD_ID}"

WORKSPACE="ceph-dashboard-pr-backend-$BUILD_ID"
mkdir $WORKSPACE
cd $WORKSPACE


extract_logs () {
    sed '/^Displaying.*/Q' consoleText > test.log
    sed '/^make check:.*/Q' test.log > build.log
    sed -i '0,/^make check:.*/d' test.log

    awk '/Displaying/,/End of/' consoleText  > daemons.log

    while grep -q -e '^End\sof' daemons.log; do
        sed '/^End of.*/q' daemons.log > tmp.log
        LOG_NAME=$(head -n 1 tmp.log | grep -o '\w*\.\w*\.log')
        mv tmp.log $LOG_NAME
        sed -i  '0,/^End of.*/d' daemons.log
    done

    rm daemons.log
}

wget -q "${BUILD_URL}/consoleText"
extract_logs
gzip consoleText
echo "Logs are saved to ${WORKSPACE}"
