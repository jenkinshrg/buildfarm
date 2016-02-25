#!/bin/bash

if [ $# -lt 1 ] ;  then
  echo "Usage:" $0 "nodename [url]"
  exit
fi

NAME=$1
URL=${2:-http://jenkinshrg.a01.aist.go.jp}

sudo useradd -s /bin/bash -m jenkins-slave

sudo su -l jenkins-slave -c "wget -q "$URL"/jnlpJars/slave.jar"

cat << EOL | sudo tee /etc/default/jenkins-slave
# defaults for jenkins continuous integration server

# pulled in from the init script; makes things easier.
NAME=jenkins-slave

# location of java
JAVA=/usr/bin/java

# arguments to pass to java
JAVA_ARGS=""  # Allow graphs etc. to work even when an X server is present
#JAVA_ARGS="-Xmx256m"
#JAVA_ARGS="-Djava.net.preferIPv4Stack=true" # make jenkins listen on IPv4 address

PIDFILE=/var/run/\$NAME/\$NAME.pid

# user and group to be invoked as (default to jenkins)
JENKINS_USER=\$NAME
JENKINS_GROUP=\$NAME

# location of the jenkins war file
JENKINS_WAR=/home/\$NAME/slave.jar

# jenkins home location
JENKINS_HOME=/home/\$NAME

# set this to false if you don't want Hudson to run by itself
# in this set up, you are expected to provide a servlet container
# to host jenkins.
RUN_STANDALONE=true

# log location.  this may be a syslog facility.priority
JENKINS_LOG=/var/log/\$NAME/\$NAME.log
#JENKINS_LOG=daemon.info

# OS LIMITS SETUP
#   comment this out to observe /etc/security/limits.conf
#   this is on by default because http://github.com/jenkinsci/jenkins/commit/2fb288474e980d0e7ff9c4a3b768874835a3e92e
#   reported that Ubuntu's PAM configuration doesn't include pam_limits.so, and as a result the # of file
#   descriptors are forced to 1024 regardless of /etc/security/limits.conf
MAXOPENFILES=8192

# set the umask to control permission bits of files that Jenkins creates.
#   027 makes files read-only for group and inaccessible for others, which some security sensitive users
#   might consider benefitial, especially if Jenkins runs in a box that's used for multiple purposes.
#   Beware that 027 permission would interfere with sudo scripts that run on the master (JENKINS-25065.)
#
#   Note also that the particularly sensitive part of \$JENKINS_HOME (such as credentials) are always
#   written without 'others' access. So the umask values only affect job configuration, build records,
#   that sort of things.
#
#   If commented out, the value from the OS is inherited,  which is normally 022 (as of Ubuntu 12.04,
#   by default umask comes from pam_umask(8) and /etc/login.defs

# UMASK=027

# port for HTTP connector (default 8080; disable with -1)
HTTP_PORT=8080

# port for AJP connector (disabled by default)
AJP_PORT=-1

# servlet context, important if you want to use apache proxying  
PREFIX=/\$NAME

# arguments to pass to jenkins.
# --javahome=\$JAVA_HOME
# --httpPort=\$HTTP_PORT (default 8080; disable with -1)
# --httpsPort=\$HTTP_PORT
# --ajp13Port=\$AJP_PORT
# --argumentsRealm.passwd.\$ADMIN_USER=[password]
# --argumentsRealm.roles.\$ADMIN_USER=admin
# --webroot=~/.jenkins/war
# --prefix=\$PREFIX

JENKINS_ARGS="-jnlpUrl $URL/computer/$NAME/slave-agent.jnlp"
EOL

cat << \EOL | sudo tee /etc/init.d/jenkins-slave
#!/bin/bash
# /etc/init.d/jenkins
# debian-compatible jenkins startup script.
# Amelia A Lewis <alewis@ibco.com>
#
### BEGIN INIT INFO
# Provides:          jenkins
# Required-Start:    $remote_fs $syslog $network
# Required-Stop:     $remote_fs $syslog $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start Jenkins at boot time
# Description:       Controls Jenkins Continuous Integration Server
### END INIT INFO

PATH=/bin:/usr/bin:/sbin:/usr/sbin

DESC="Jenkins Continuous Integration Server"
NAME=jenkins-slave
SCRIPTNAME=/etc/init.d/$NAME

[ -r /etc/default/$NAME ] && . /etc/default/$NAME

#DAEMON=$JENKINS_SH
DAEMON=/usr/bin/daemon
DAEMON_ARGS="--name=$NAME --inherit --env=JENKINS_HOME=$JENKINS_HOME --output=$JENKINS_LOG --pidfile=$PIDFILE"

if [ -n "$UMASK" ]; then
    DAEMON_ARGS="$DAEMON_ARGS --umask=$UMASK"
fi

SU=/bin/su

# Exit if the package is not installed
if [ ! -x "$DAEMON" ]; then
    echo "daemon package not installed" >&2
    exit 1
fi

# Exit if not supposed to run standalone
if [ "$RUN_STANDALONE" = "false" ]; then
    echo "Not configured to run standalone" >&2
    exit 1
fi

# load environments
if [ -r /etc/default/locale ]; then
  . /etc/default/locale
  export LANG LANGUAGE
elif [ -r /etc/environment ]; then
  . /etc/environment
  export LANG LANGUAGE
fi

# Load the VERBOSE setting and other rcS variables
. /lib/init/vars.sh

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.0-6) to ensure that this file is present.
. /lib/lsb/init-functions

# Make sure we run as root, since setting the max open files through
# ulimit requires root access
if [ `id -u` -ne 0 ]; then
    echo "The $NAME init script can only be run as root"
    exit 1
fi


check_tcp_port() {
    local service=$1
    local assigned=$2
    local default=$3

    if [ -n "$assigned" ]; then 
        port=$assigned
    else
        port=$default
    fi
    
    count=`netstat --listen --numeric-ports | grep \:$port[[:space:]] | grep -c . `
    
    if [ $count -ne 0 ]; then
        echo "The selected $service port ($port) seems to be in use by another program "
        echo "Please select another port to use for $NAME"
        return 1
    fi
}

#
# Function that starts the daemon/service
#
do_start()
{
    # the default location is /var/run/jenkins/jenkins.pid but the parent directory needs to be created
    mkdir `dirname $PIDFILE` > /dev/null 2>&1 || true
    chown $JENKINS_USER `dirname $PIDFILE`
    # Return
    #   0 if daemon has been started
    #   1 if daemon was already running
    #   2 if daemon could not be started
    $DAEMON $DAEMON_ARGS --running && return 1

    # Verify that the jenkins port is not already in use, winstone does not exit
    # even for BindException
    # check_tcp_port "http" "$HTTP_PORT" "8080" || return 2
    
    # If the var MAXOPENFILES is enabled in /etc/default/jenkins then set the max open files to the 
    # proper value
    if [ -n "$MAXOPENFILES" ]; then
        [ "$VERBOSE" != no ] && echo Setting up max open files limit to $MAXOPENFILES
        ulimit -n $MAXOPENFILES
    fi
    
    # notify of explicit umask
    if [ -n "$UMASK" ]; then
        [ "$VERBOSE" != no ] && echo Setting umask to $UMASK
    fi

    # --user in daemon doesn't prepare environment variables like HOME, USER, LOGNAME or USERNAME,
    # so we let su do so for us now
    $SU -l $JENKINS_USER --shell=/bin/bash -c "$DAEMON $DAEMON_ARGS -- $JAVA $JAVA_ARGS -jar $JENKINS_WAR $JENKINS_ARGS" || return 2
}


#
# Verify that all jenkins processes have been shutdown
# and if not, then do killall for them
# 
get_running() 
{
    return `ps -U $JENKINS_USER --no-headers -f | egrep -e '(java|daemon)' | grep -c . `
}

force_stop() 
{
    get_running
    if [ $? -ne 0 ]; then 
	killall -u $JENKINS_USER java daemon || return 3
    fi
}

# Get the status of the daemon process
get_daemon_status()
{
    $DAEMON $DAEMON_ARGS --running || return 1
}


#
# Function that stops the daemon/service
#
do_stop()
{
    # Return
    #   0 if daemon has been stopped
    #   1 if daemon was already stopped
    #   2 if daemon could not be stopped
    #   other if a failure occurred
    get_daemon_status 
    case "$?" in
	0) 
	    $DAEMON $DAEMON_ARGS --stop || return 2
        # wait for the process to really terminate
        for n in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20; do
            sleep 1
            $DAEMON $DAEMON_ARGS --running || break
        done
        if get_daemon_status; then
	        force_stop || return 3
        fi
	    ;;
	*)
	    force_stop || return 3
	    ;;
    esac

    # Many daemons don't delete their pidfiles when they exit.
    rm -f $PIDFILE
    return 0
}

# Verify the process did in fact start successfully and didn't just bomb out
do_check_started_ok() {
    sleep 1
    if [ "$1" -ne "0" ]; then return $1; fi
    get_running
    if [ "$?" -eq "0" ]; then
        return 2
    else 
        return 0
    fi
}

case "$1" in
  start)
    log_daemon_msg "Starting $DESC" "$NAME"
    do_start
    START_STATUS="$?"
    do_check_started_ok "$START_STATUS"
    case "$?" in
        0|1) log_end_msg 0 ;;
        2) log_end_msg 1 ; exit 7 ;;
    esac
    ;;
  stop)
    log_daemon_msg "Stopping $DESC" "$NAME"
    do_stop
    case "$?" in
        0|1) log_end_msg 0 ;;
        2) log_end_msg 1 ; exit 100 ;;
    esac
    ;;
  restart|force-reload)
    #
    # If the "reload" option is implemented then remove the
    # 'force-reload' alias
    #
    log_daemon_msg "Restarting $DESC" "$NAME"
    do_stop
    case "$?" in
      0|1)
        do_start
        START_STATUS="$?"
        sleep 1
        do_check_started_ok "$START_STATUS"
        case "$?" in
          0) log_end_msg 0 ;;
          1) log_end_msg 1 ; exit 100 ;; # Old process is still running
          *) log_end_msg 1 ; exit 100 ;; # Failed to start
        esac
        ;;
      *)
  	# Failed to stop
	log_end_msg 1
	;;
    esac
    ;;
  status)
	get_daemon_status
	case "$?" in 
	 0) 
		echo "$DESC is running with the pid `cat $PIDFILE`"
		rc=0
		;;
	*) 
		get_running
		procs=$?
		if [ $procs -eq 0 ]; then 
			echo -n "$DESC is not running"
			if [ -f $PIDFILE ]; then 
				echo ", but the pidfile ($PIDFILE) still exists"
				rc=1
			else 
				echo
				rc=3
			fi
		
		else 
			echo "$procs instances of jenkins are running at the moment"
			echo "but the pidfile $PIDFILE is missing"
			rc=0
		fi
		
		exit $rc
		;;
	esac
	;;
  *)
    echo "Usage: $SCRIPTNAME {start|stop|status|restart|force-reload}" >&2
    exit 3
    ;;
esac

exit 0
EOL
sudo chmod 755 /etc/init.d/jenkins-slave

sudo mkdir -p /var/log/jenkins-slave
sudo chown -R jenkins-slave.jenkins-slave /var/log/jenkins-slave

sudo update-rc.d jenkins-slave defaults
sudo service jenkins-slave start

sudo sh -c 'echo "jenkins-slave ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'
