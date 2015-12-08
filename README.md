# buildfarm

## setup master

```
vagrant up
```

## setup slave

```
vagrant up slave slave-32 slave-64
```

## setup slave (desktop)

```
./scripts/createnode.sh slave-desktop /home/tokunaga http://jenkinshrg
./scripts/createjob.sh drcutil-desktop https://github.com/jenkinshrg/drcutil.git drcutil ubuntu-trusty-amd64 slave-desktop periodic http://jenkinshrg
./setup/jnlp.sh slave-desktop http://jenkinshrg
```
