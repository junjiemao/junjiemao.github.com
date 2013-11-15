#!/bin/bash
emacs -nw $(rake post title="$1" | gawk -F ':' '{print $2}')
