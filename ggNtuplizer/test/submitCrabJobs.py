#!/usr/bin/env python

from __future__ import print_function, division

import subprocess, argparse
inputArgumentsParser = argparse.ArgumentParser(description='Submit crab jobs for the stealth analysis.')
inputArgumentsParser.add_argument('--isProductionRun', action='store_true', help="By default, this script submits dry runs. Passing this switch will submit full production jobs.")
inputArguments = inputArgumentsParser.parse_args()

for dataset in ["JetHT", "DoubleEG"]:
    for era in ["B", "C", "D", "E", "F"]:
        commandToSubmit = "./submitCrabJobHelper.sh configFile=data_crabConfig.py requestSuffix=data_{d}_2017{e} workareaSuffix=data_{d}_2017{e} inputDataset=/{d}/Run2017{e}-31Mar2018-v1/MINIAOD outputDirectory=data_{d}_2017{e} unitsPerJob=20".format(d=dataset, e=era)
        if (inputArguments.isProductionRun): commandToSubmit += " dryRunFlag=0"
        subprocess.check_call(commandToSubmit, shell=True)
