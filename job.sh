#                      jobname                  template node           os     distro arch  script      script_args
./scripts/createjob.sh drcutil                  scm      150.29.145.15  none   none   none  .jenkins.sh
./scripts/createjob.sh drcutil-build-32         upstream 150.29.145.15  debian wheezy i386  .jenkins.sh build
./scripts/createjob.sh drcutil-build-64         upstream 150.29.145.15  ubuntu trusty amd64 .jenkins.sh build
./scripts/createjob.sh drcutil-task-balancebeam periodic 150.29.145.169 none   none   none  .jenkins.sh task HRP2KAI irex-balance-beam-auto 640 170 550 220 300
./scripts/createjob.sh drcutil-task-terrain     periodic 150.29.145.169 none   none   none  .jenkins.sh task HRP2KAI testbed-terrain 620 170 530 220 300
./scripts/createjob.sh drcutil-task-valve       periodic 150.29.145.169 none   none   none  .jenkins.sh task HRP2KAI drc-valves 870 1000 760 1050 300 valve_left q
#./scripts/createjob.sh drcutil-task-wall        periodic 150.29.145.169 none   none   none  .jenkins.sh task HRP2KAI drc-wall-testbed 640 170 550 220 540 tool waistAbsTransform
./scripts/createjob.sh drcutil-task-wall        periodic 150.29.145.169 none   none   none  .jenkins.sh task HRP2KAI drc-wall-testbed 640 170 550 220 540
./scripts/createjob.sh drcutil-upload           none     150.29.145.15  none   none   none  report.sh
