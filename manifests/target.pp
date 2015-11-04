#
# == Class: setfacl::target
#
# Set the default POSIX Extended ACLs on the given target file/directory - 
# recursively or non-recursively.
#
# For details on POSIX ACLs and their Linux implementation look here:
#
# <http://users.suse.com/~agruen/acl/linux-acls/online>
#
# There _is_ at least one  Puppet module for managing ACLs:
#
# <https://github.com/dobbymoodge/puppet-acl>
#
# The above module is currently unmaintained and has one fatal flaw: when 
# managing ACLs recursively it does not detect changes to the underlying files, 
# only changes to the Puppet parameters. What this means is that if files with 
# wrong extended ACLs are added manually under the managed directory the module 
# won't fix them. Because Puppet modules are _not_ managed by Puppet, someone 
# will eventually "cp -a" something with wrong Extended ACLs under the module 
# directory, even if default ACLs are set correctly.
#
# Changes to Extended ACLs of any file in a directory could be detected like 
# this:
#
# $ getfacl --omit-header -R environments/|sha1sum
#
# Even in this case the hash from previous Puppet run would have to be stored 
# somewhere and compared to the new one in order to detect any changes. Even 
# this approach would produce useless Puppet runs if Extended ACLs not managed 
# by the Puppet module had changed. This can happen if the acl class parameter 
# $action is not set to 'exact'.
#
# To keep things simple this module just runs "setfacl" unconditionally from 
# within an Exec.
#
# == Parameters
#
# [*paths*]
#   An array of filesystem paths to apply the ACLs to.
# [*recurse*]
#   Recursively set ACLs for all files/directories beneath $path. Valid values 
#   are true and false (default).
# [*acls*]
#   An array of ACLs to set. Example
#   
#   [ 'default:mask::rwx',
#     'mask::rwx',
#     'default:g:wheel:rwx',
#     'g:wheel:rwx' ]
#
define setfacl::target
(
    $paths,
    $acls,
    $recurse = false
)
{
    validate_array($paths)
    validate_array($acls)
    validate_bool($recurse)

    include ::setfacl::params

    # Generate strings from the array parameters
    $paths_str = join($paths, ' ')
    $acl_str = join($acls, ',')

    if $recurse {
        $basecmd = 'setfacl -R'
    } else {
        $basecmd = 'setfacl'
    }

    exec { "setfacl-${title}":
        command => "${basecmd} -P -n -m \'${acl_str}\' ${paths_str}",
        path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin'],
    }
}
