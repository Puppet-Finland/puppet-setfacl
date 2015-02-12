#
# == Class: setfacl:install
#
# Install setfacl (and related ACL-management tools)
#
class setfacl::install inherits setfacl::params {

    package { 'setfacl-acl':
        name => $::setfacl::params::package_name,
        ensure => installed,
    }
}
