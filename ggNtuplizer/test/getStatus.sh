#!/bin/bash

source /cvmfs/cms.cern.ch/crab3/crab.sh

for crabdir in `find . -mindepth 2 -maxdepth 2 -type d | grep "crab_workArea"`; do
    echo "Found crabdir = ${crabdir}. Status:"
    crab status -d ${crabdir}
done
