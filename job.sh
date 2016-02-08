#                      jobname                  repository                                             directory            branch  node                        trigger  script params
./scripts/createjob.sh drcutil                  https://github.com/jenkinshrg/drcutil.git              drcutil              jenkins slave                       scm
./scripts/createjob.sh drcutil-build-32         https://github.com/jenkinshrg/drcutil.git              drcutil              jenkins debian-wheezy-i386          upstream build
./scripts/createjob.sh drcutil-build-64         https://github.com/jenkinshrg/drcutil.git              drcutil              jenkins ubuntu-trusty-amd64         upstream build
./scripts/createjob.sh drcutil-test             https://github.com/jenkinshrg/drcutil.git              drcutil              jenkins ubuntu-trusty-amd64         upstream test
./scripts/createjob.sh drcutil-analysis         https://github.com/jenkinshrg/drcutil.git              drcutil              jenkins ubuntu-trusty-amd64         upstream analysis
./scripts/createjob.sh drcutil-inspection       https://github.com/jenkinshrg/drcutil.git              drcutil              jenkins ubuntu-trusty-amd64         upstream inspection
./scripts/createjob.sh drcutil-task-balancebeam https://github.com/jenkinshrg/drcutil.git              drcutil              jenkins ubuntu-trusty-amd64-desktop periodic task balancebeam
./scripts/createjob.sh drcutil-task-terrain     https://github.com/jenkinshrg/drcutil.git              drcutil              jenkins ubuntu-trusty-amd64-desktop periodic task terrain
./scripts/createjob.sh drcutil-task-valve       https://github.com/jenkinshrg/drcutil.git              drcutil              jenkins ubuntu-trusty-amd64-desktop periodic task valve
./scripts/createjob.sh drcutil-task-walk        https://github.com/jenkinshrg/drcutil.git              drcutil              jenkins ubuntu-trusty-amd64-desktop periodic task walk
./scripts/createjob.sh drcutil-task-wall        https://github.com/jenkinshrg/drcutil.git              drcutil              jenkins ubuntu-trusty-amd64-desktop periodic task wall
./scripts/createjob.sh report                   https://github.com/jenkinshrg/jenkinshrg.github.io.git jenkinshrg.github.io master  slave
