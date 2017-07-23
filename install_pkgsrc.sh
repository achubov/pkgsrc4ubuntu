#!/bin/bash
# This script for installing pkgsrc (NetBSD) on Ubuntu.
# Author: Alex Chubov
# Contact: achubov@gmail.com

# Install dependencies
apt-get -y install cvs libncurses5-dev gcc g++ zlib1g-dev zlib1g libssl-dev libudev-dev

# Install pkgsrc
cd /usr
cvs -danoncvs@anoncvs.netbsd.org:/cvsroot checkout pkgsrc
cd pkgsrc/bootstrap
export SH=/bin/bash
./bootstrap

# Download vulnerabilities file
/usr/pkg/sbin/pkg_admin fetch-pkg-vulnerabilities 

# Audit the installed packages and email results to root
/usr/pkg/sbin/pkg_admin audit |mail -s "Installed package audit result" \
	    root >/dev/null 2>&1

# ---> Add cron jobs
# Download vulnerabilities file
#0 3 * * * /usr/pkg/sbin/pkg_admin fetch-pkg-vulnerabilities >/dev/null 2>&1
# Audit the installed packages and email results to root
#9 3 * * * /usr/pkg/sbin/pkg_admin audit |mail -s "Installed package audit result" \
	    root >/dev/null 2>&1

#echo 'export PATH=$PATH:/usr/pkg/bin' >>
#echo 'export MANPATH=$MANPATH:/usr/pkg/man' >>
