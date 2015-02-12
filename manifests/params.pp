#
# == Class: setfacl::params
#
# Defines some variables based on the operating system
#
class setfacl::params {

    include os::params

    case $::osfamily {
        'RedHat': {
            $package_name = 'acl'
        }
        'Debian': {
            $package_name = 'acl'
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
