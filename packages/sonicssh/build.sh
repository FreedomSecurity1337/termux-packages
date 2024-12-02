TERMUX_PKG_HOMEPAGE=https://github.com/FreedomSecurity1337/SonicSSH
TERMUX_PKG_DESCRIPTION="SonicSSH Faster and simple SSH brute force tool"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="Freedom Security idrei1337@gmail.com"
TERMUX_PKG_VERSION=1.0
TERMUX_PKG_SRCURL=https://github.com/FreedomSecurity1337/SonicSSH/archive/refs/heads/main.zip
TERMUX_PKG_SHA256=skip
TERMUX_PKG_DEPENDS="openssh"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make_install() {
    install -Dm700 sonicssh.sh $TERMUX_PREFIX/bin/sonicssh
}
