#!/bin/bash
# LICENSE UPL 1.0
#
# Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved.
#
# Since: January, 2018
# Author: sanjay.singh@oracle.com, paramdeep.saini@oracle.com
# Description: Runs user shell and SQL scripts
# 
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
# 

SCRIPTS_ROOT="$1";
SCRIPTS_TYPE="$2";

# Check whether parameter has been passed on
if [ -z "$SCRIPTS_ROOT" ]; then
   echo "$0: No SCRIPTS_ROOT passed on, no scripts will be run";
else

# Execute custom provided files (only if directory exists and has files in it)
if [ "${SCRIPTS_TYPE}" == "DB" ] && [ -d "$SCRIPTS_ROOT" ] && [ -n "$(ls -A $SCRIPTS_ROOT)" ]; then

  echo "";
  echo "Executing user defined scripts for ${SCRIPTS_TYPE}"

  for f in $SCRIPTS_ROOT/*; do
      case "$f" in
          *.sh)     echo "$0: running $f"; . "$f" ;;
          *.sql)    echo "$0: running $f"; echo "exit" | $ORACLE_HOME/bin/sqlplus -s "/ as sysdba" @"$f"; echo ;;
          *)        echo "$0: ignoring $f" ;;
      esac
      echo "";
  done
  
  echo "DONE: Executing user defined scripts for ${SCRIPTS_TYPE}"
  echo "";

fi;

fi;
 
if [ -z "$SCRIPTS_ROOT" ]; then
   echo "$0: No SCRIPTS_ROOT passed on, no scripts will be run";

else

# Execute custom provided files (only if directory exists and has files in it)
if [ "${SCRIPTS_TYPE}" == "GRID" ] && [ -d "$SCRIPTS_ROOT" ] && [ -n "$(ls -A $SCRIPTS_ROOT)" ]; then

  echo "";
  echo "Executing user defined scripts for ${SCRIPTS_TYPE}"

  for f in $SCRIPTS_ROOT/*; do
      case "$f" in
          *.sh)     echo "$0: running $f"; . "$f" ;;
          *.sql)    echo "$0: running $f"; echo "exit" | $ORACLE_HOME/bin/sqlplus -s "/ as sysasm" @"$f"; echo ;;
          *)        echo "$0: ignoring $f" ;;
      esac
      echo "";
  done

  echo "DONE: Executing user defined scripts for ${SCRIPTS_TYPE}"
  echo "";

fi;

fi;
