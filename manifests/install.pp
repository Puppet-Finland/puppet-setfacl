#
# == Class: setfacl:install
#
# Install setfacl (and related ACL-management tools)
#
class setfacl::install inherits setfacl::params {

    package { 'setfacl-acl':
        ensure => installed,
        name   => $::setfacl::params::package_name,
    }
}
