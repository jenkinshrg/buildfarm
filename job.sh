./scripts/cli/createjob.sh drcutil https://github.com/jenkinshrg/drcutil.git drcutil jenkins slave scm
./scripts/cli/createjob.sh", args: "drcutil-build-32 https://github.com/jenkinshrg/drcutil.git drcutil jenkins debian-wheezy-i386 upstream build
./scripts/cli/createjob.sh", args: "drcutil-build-64 https://github.com/jenkinshrg/drcutil.git drcutil jenkins ubuntu-trusty-amd64 upstream build
./scripts/cli/createjob.sh", args: "drcutil-test https://github.com/jenkinshrg/drcutil.git drcutil jenkins ubuntu-trusty-amd64 upstream test
./scripts/cli/createjob.sh", args: "drcutil-analysis https://github.com/jenkinshrg/drcutil.git drcutil jenkins ubuntu-trusty-amd64 upstream analysis
./scripts/cli/createjob.sh", args: "drcutil-inspection https://github.com/jenkinshrg/drcutil.git drcutil jenkins ubuntu-trusty-amd64 upstream inspection
./scripts/cli/createjob.sh", args: "drcutil-task-balancebeam https://github.com/jenkinshrg/drcutil.git drcutil jenkins ubuntu-trusty-amd64-desktop periodic task balancebeam
./scripts/cli/createjob.sh", args: "drcutil-task-terrain https://github.com/jenkinshrg/drcutil.git drcutil jenkins ubuntu-trusty-amd64-desktop periodic task terrain
./scripts/cli/createjob.sh", args: "drcutil-task-valve https://github.com/jenkinshrg/drcutil.git drcutil jenkins ubuntu-trusty-amd64-desktop periodic task valve
./scripts/cli/createjob.sh", args: "drcutil-task-walk https://github.com/jenkinshrg/drcutil.git drcutil jenkins ubuntu-trusty-amd64-desktop periodic task walk
./scripts/cli/createjob.sh", args: "drcutil-task-wall https://github.com/jenkinshrg/drcutil.git drcutil jenkins ubuntu-trusty-amd64-desktop periodic task wall
./scripts/cli/createjob.sh", args: "report https://github.com/jenkinshrg/jenkinshrg.github.io.git jenkinshrg.github.io master slave
