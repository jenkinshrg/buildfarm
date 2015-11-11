# buildfarm

## setup server

```
vagrant up
```

```
vagrant up slave slave-32 slave-64
```

## setup desktop

```
./scripts/createnode.sh slave-desktop /home/tokunaga http://jenkinshrg
./scripts/createjob.sh drcutil-desktop https://github.com/jenkinshrg/drcutil.git drcutil ubuntu-trusty-amd64 slave-desktop periodic http://jenkinshrg
```

```
./setup/update.sh
./scripts/desktop.sh
./scripts/scm.sh
./scripts/devel.sh
./scripts/jnlp.sh slave-desktop http://jenkinshrg
```
