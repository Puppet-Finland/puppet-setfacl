# setfacl

A Puppet module for setting arbitrary ACLs on Linux. This module uses the 
setfacl command directly and allows recursive, guaranteed management of ACLs at 
the expense of dumbly running setfacl on every Puppet run.

# Module usage

* [Class: setfacl](manifests/init.pp)
* [Define: setfacl::target](manifests/target.pp)

# Dependencies

See [metadata.json](metadata.json).

# Operating system support

This module has been tested on

* CentOS 6
* Ubuntu 14.04

Any Linux flavour should work out of the box or with minor modifications.

For details see [params.pp](manifests/params.pp).
