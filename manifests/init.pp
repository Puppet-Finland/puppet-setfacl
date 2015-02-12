#
# == Class: setfacl
#
# A Puppet module for managing Extended POSIX ACLs. More details are available 
# in the setfacl::target define.
#
# == Parameters
#
# [*targets*]
#   A hash of setfacl::target defined resources to realize.
# 
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class setfacl
(
    $targets = {}
)
{
    include setfacl::install

    create_resources('setfacl::target', $targets)

}
