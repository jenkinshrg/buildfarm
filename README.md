# buildfarm

## setup master

```
vagrant up master
```

## setup slave

```
vagrant up slave debian-wheezy-i386 ubuntu-trusty-amd64
```

## setup slave (desktop)

```
./scripts/createnode.sh ubuntu-trusty-amd64-desktop /home/tokunaga http://jenkinshrg
./scripts/createjob.sh drcutil-desktop https://github.com/jenkinshrg/drcutil.git drcutil ubuntu-trusty-amd64 ubuntu-trusty-amd64-desktop periodic http://jenkinshrg
./setup/jnlp.sh ubuntu-trusty-amd64-desktop http://jenkinshrg
```
