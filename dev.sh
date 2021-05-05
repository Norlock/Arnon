#!/bin/bash
nohup npx sass --watch ./sass/:css/ > /home/norlock/Projects/Arnon/sass.log 2>&1 &
elm reactor
trap 'kill $(jobs -p)' EXIT
