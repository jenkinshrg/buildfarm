#                      jobname                  template node           os     distro arch  script      script_args
./scripts/createjob.sh drcutil                  scm      150.29.145.15  none   none   none  .jenkins.sh
./scripts/createjob.sh drcutil-build-32         upstream 150.29.145.15  debian wheezy i386  .jenkins.sh build
./scripts/createjob.sh drcutil-build-64         upstream 150.29.145.15  ubuntu trusty amd64 .jenkins.sh build
./scripts/createjob.sh drcutil-task-balancebeam periodic 150.29.145.169 none   none   none  .jenkins.sh task balancebeam
./scripts/createjob.sh drcutil-task-terrain     periodic 150.29.145.169 none   none   none  .jenkins.sh task terrain
./scripts/createjob.sh drcutil-task-valve       periodic 150.29.145.169 none   none   none  .jenkins.sh task valve
./scripts/createjob.sh drcutil-task-wall        periodic 150.29.145.169 none   none   none  .jenkins.sh task wall
./scripts/createjob.sh drcutil-upload           none     150.29.145.15  none   none   none  report.sh
