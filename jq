#!/bin/sh

case `uname -s` in
  Darwin*)
    jq-osx "$@";;
  Linux*)
    jq-linux "$@";;
  *)
    echo "not supported system `uname -s`";;
esac
