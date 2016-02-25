./scripts/createjob.sh drcutil                  scm      slave1 none   none   none  .jenkins.sh
./scripts/createjob.sh drcutil-build-32         upstream slave1 debian wheezy i386  .jenkins.sh build
./scripts/createjob.sh drcutil-build-64         upstream slave1 ubuntu trusty amd64 .jenkins.sh build
./scripts/createjob.sh drcutil-task-balancebeam periodic slave2 none   none   none  .jenkins.sh task HRP2KAI irex-balance-beam-auto 640 170 550 220 300
./scripts/createjob.sh drcutil-task-terrain     periodic slave2 none   none   none  .jenkins.sh task HRP2KAI testbed-terrain 620 170 530 220 300
./scripts/createjob.sh drcutil-task-valve       periodic slave2 none   none   none  .jenkins.sh task HRP2KAI drc-valves 870 1000 760 1050 300 valve_left q
#./scripts/createjob.sh drcutil-task-wall        periodic slave2 none   none   none  .jenkins.sh task HRP2KAI drc-wall-testbed 640 170 550 220 540 tool waistAbsTransform
./scripts/createjob.sh drcutil-task-wall        periodic slave2 none   none   none  .jenkins.sh task HRP2KAI drc-wall-testbed 640 170 550 220 540
./scripts/createjob.sh drcutil-upload           none     slave1 none   none   none  report.sh
