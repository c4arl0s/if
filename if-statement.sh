#!/bin/bash

var_one=1
var_two=0
var_three=1

# Only one flag might be set
flag_one=
flag_two=
flag_three=

# draw table of thruth

if [[ "${var_one}" ]] && [[ "${var_three}" ]] && { [[ -z "${flag_one}" ]] && [[ -z "${flag_two}" ]] && [[ -z "${flag_three}" ]]; }; then
  echo "flag_one=$flag_one"
  echo "flag_two=$flag_two"
  echo "flag_three=$flag_three"
  echo "all flags are length zero"
  exit 1
fi
