#                      jobname                  node           os     distro arch  trigger  func           script_args
./scripts/createjob.sh drcutil                  150.29.145.15  none   none   none  scm      .jenkinshrg.sh
./scripts/createjob.sh drcutil-build-32         150.29.145.15  debian wheezy i386  upstream .jenkinshrg.sh build
./scripts/createjob.sh drcutil-build-64         150.29.145.15  ubuntu trusty amd64 upstream .jenkinshrg.sh build
./scripts/createjob.sh drcutil-task-balancebeam 150.29.145.169 none   none   none  periodic .jenkinshrg.sh task balancebeam
./scripts/createjob.sh drcutil-task-terrain     150.29.145.169 none   none   none  periodic .jenkinshrg.sh task terrain
./scripts/createjob.sh drcutil-task-valve       150.29.145.169 none   none   none  periodic .jenkinshrg.sh task valve
./scripts/createjob.sh drcutil-task-wall        150.29.145.169 none   none   none  periodic .jenkinshrg.sh task wall
./scripts/createjob.sh report                   150.29.145.15  none   none   none  none     .jenkinshrg.sh
