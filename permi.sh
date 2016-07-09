#!/bin/bash

### Metadata
name="permi"
source="github.com/jcmdln/permi"
manual="github.com/jcmdln/permi/wiki"
description="$name is a script to correct permissions of Linux/Unix users. Primarily created to correct permissions in enviroments that use suPHP/FastCGI in cPanel, but adapted to allow other permission sets that target generic users rather than focusing on cPanel (or Apache/PHP for that matter)."


### Check Apache & PHP Handler
[[ $(cat /usr/local/apache/conf/php.conf) == "suPHP_Engine on" ]]; php_handler="suPHP"
[[ $(cat /usr/local/apache/conf/php.conf) == "mod_so" ]]; php_handler="DSO"
[[ $(cat /usr/local/apache/conf/php.conf) == "mod_so" && \ 
   $(cat /usr/local/apache/conf/httpd.conf) == "mod_ruid2" ]]; php_handler="DSO_ruid2"


### Permissions Rulesets
dontgrep="grep -v 'retained'"

DSO() {
  ## 777
  ## 771
  ## 755
  ## 751
  ## 750
  ## 711
  ## 700
  ## 644
  ## 640
  ## 600
  ## 444
  ## 400
}

DSO_ruid2() {
  ## 777
  ## 771
  ## 755
  ## 751
  ## 750
  ## 711
  ## 700
  ## 644
  ## 640
  ## 600
  ## 444
  ## 400
}

suPHP() {
  ## 755
  find $userdir/ \
    -type d \( \
    ! -path '$userdir/etc' \
    ! -path '$userdir/mail' \
    ! -path '$userdir/public_html' \
    -path '$userdir/htpasswds' \
    -path '$userdir/public_html/*' \
    -exec chmod -v 755 {} \; | $dontgrep

  find $userdir/ \
  -type
  find /home/boldbin/ \( \
    type -f
    ! -path '/home/boldbin/public_html' \
    -path '/home/boldbin/public_html/*' \) \
    -exec chmod -v 755 {} \; | $dontgrep

  ## 751
  ## 750
  ## 711
  ## 700
  ## 644

  ## 640
  find $userdir/public_html \
    -type f \
    -name '*.bmp' -o \
    -name '*.htaccess' -o \
    -name '*.*htm*' -o \
    -name '*.ico' -o \
    -name '*.jp*g' -o \
    -name '*.png' -o \
    -name '*.svg' \
    -exec chmod -v 640 {} \; | $dontgrep

  ## 600
    -name '.bashrc' -o \
    -name '.tmux.conf' -o \
    -name '.vimrc' \) \

  ## 444
  ## 400

  ## Ownership
  echo "Correcting file/folder ownership..."

  chown -v $user:root $userdir | $dontgrep
  chown -v $user:mail $userdir/mail | $dontgrep
  chown -v $user:nobody $userdir/public_html | $dontgrep

  chown -vR $user:$user $userdir/* | $dontgrep
  chown -vR $user:$user $userdir/mail/* | $dontgrep
  chown -vR $user:$user $userdir/public_html/* | $dontgrep
}


### Execution
#error() {}

user=$1
target=$2

if [ -d /home/$user ]; then
  echo "permi: Found $user in /home/"
  userdir="$(grep -e '^$usr}:' /etc/passwd | cut -d: -f6)"

  if [ -d $target ]; then
    # target exits, only run against target
  else
    echo "permi: error: target $target does not exist! Exiting..."
  fi

else
  echo "permi: error: $user not found, exiting..."
  exit
fi
