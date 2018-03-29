#!/bin/bash

while [ $# -gt 0 ]; do
  arg=$1
  case $arg in
    option_1)
     # do_option_1
    ;;
    option_2)
     # do_option_1
    ;;
    shortlist)
      echo $(ls jlink/project)
      #echo option_1 option_2 shortlist
    ;;
    *)
     echo Wrong option
    ;;
  esac
  shift
done
