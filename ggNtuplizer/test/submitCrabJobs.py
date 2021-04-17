#!/usr/bin/env python

from __future__ import print_function, division

import subprocess, argparse, os, re, sys

print("Importing environment variables...")
stealthRoot = os.getenv("STEALTH_ROOT")
stealthEOSRoot = os.getenv("STEALTH_EOS_ROOT")
stealthArchives = os.getenv("STEALTH_ARCHIVES")
stealthCMSSWBase = os.getenv("STEALTH_CMSSW_BASE")
EOSPrefix = os.getenv("EOSPREFIX")
tmUtilsParent = os.getenv("TM_UTILS_PARENT")
hostname = os.getenv("HOSTNAME")
x509Proxy = os.getenv("X509_USER_PROXY")
habitat = ""
if ("lxplus" in hostname):
    habitat = "lxplus"
elif ("fnal" in hostname):
    habitat = "fnal"
else:
    sys.exit("ERROR: Unrecognized hostname: {h}, seems to be neither lxplus nor fnal.".format(h=hostname))

print("stealthRoot: {sR}".format(sR=stealthRoot))
print("stealthEOSRoot: {sER}".format(sER=stealthEOSRoot))
print("stealthArchives: {sA}".format(sA=stealthArchives))
print("stealthCMSSWBase: {sCB}".format(sCB=stealthCMSSWBase))
print("EOSPrefix: {eP}".format(eP=EOSPrefix))
print("tmUtilsParent: {tUP}".format(tUP=tmUtilsParent))
print("hostname: {hN}".format(hN=hostname))
print("x509Proxy: {xP}".format(xP=x509Proxy))
print("Setting habitat = {h}".format(h=habitat))

inputArgumentsParser = argparse.ArgumentParser(description='Submit crab jobs for the stealth analysis.')
inputArgumentsParser.add_argument('--year', default="all", help="Year of data-taking.", type=str)
inputArgumentsParser.add_argument('--version', required=True, help="Version name -- included in output directory name.", type=str)
inputArgumentsParser.add_argument('--isProductionRun', action='store_true', help="By default, this script submits dry runs. Passing this switch will submit full production jobs.")
inputArguments = inputArgumentsParser.parse_args()

def execute_in_crab_env(commandToRun, printDebug=False):
    current_working_directory = os.getcwd()
    env_setup_command = "bash -c \"cd {sR} && source setupEnv.sh && source /cvmfs/cms.cern.ch/crab3/crab.sh && cd {cwd}".format(sR=stealthRoot, cwd=current_working_directory)
    runInEnv = "{e_s_c} && set -x && {c} && set +x\"".format(e_s_c=env_setup_command, c=commandToRun)
    if (printDebug):
        print("About to execute command:")
        print("{c}".format(c=runInEnv))
    os.system(runInEnv)

datasets = {
    2016: [
        # "/DoubleEG/Run2016B-17Jul2018_ver2-v1/MINIAOD",
        # "/DoubleEG/Run2016C-17Jul2018-v1/MINIAOD",
        # "/DoubleEG/Run2016D-17Jul2018-v1/MINIAOD",
        # "/DoubleEG/Run2016E-17Jul2018-v1/MINIAOD",
        # "/DoubleEG/Run2016F-17Jul2018-v1/MINIAOD",
        # "/DoubleEG/Run2016G-17Jul2018-v1/MINIAOD",
        # "/DoubleEG/Run2016H-17Jul2018-v1/MINIAOD",
        "/SinglePhoton/Run2016B-17Jul2018_ver2-v1/MINIAOD",
        "/SinglePhoton/Run2016C-17Jul2018-v1/MINIAOD",
        "/SinglePhoton/Run2016D-17Jul2018-v1/MINIAOD",
        "/SinglePhoton/Run2016E-17Jul2018-v1/MINIAOD",
        "/SinglePhoton/Run2016F-17Jul2018-v1/MINIAOD",
        "/SinglePhoton/Run2016G-17Jul2018-v1/MINIAOD",
        "/SinglePhoton/Run2016H-17Jul2018-v1/MINIAOD",
        # "/JetHT/Run2016B-17Jul2018_ver2-v2/MINIAOD",
        # "/JetHT/Run2016C-17Jul2018-v1/MINIAOD",
        # "/JetHT/Run2016D-17Jul2018-v1/MINIAOD",
        # "/JetHT/Run2016E-17Jul2018-v1/MINIAOD",
        # "/JetHT/Run2016F-17Jul2018-v1/MINIAOD",
        # "/JetHT/Run2016G-17Jul2018-v1/MINIAOD",
        # "/JetHT/Run2016H-17Jul2018-v1/MINIAOD"
    ],
    2017: [
        # "/DoubleEG/Run2017B-31Mar2018-v1/MINIAOD",
        # "/DoubleEG/Run2017C-31Mar2018-v1/MINIAOD",
        # "/DoubleEG/Run2017D-31Mar2018-v1/MINIAOD",
        # "/DoubleEG/Run2017E-31Mar2018-v1/MINIAOD",
        # "/DoubleEG/Run2017F-31Mar2018-v1/MINIAOD",
        "/SinglePhoton/Run2017B-31Mar2018-v1/MINIAOD",
        "/SinglePhoton/Run2017C-31Mar2018-v1/MINIAOD",
        "/SinglePhoton/Run2017D-31Mar2018-v1/MINIAOD",
        "/SinglePhoton/Run2017E-31Mar2018-v1/MINIAOD",
        "/SinglePhoton/Run2017F-31Mar2018-v1/MINIAOD",
        # "/JetHT/Run2017B-31Mar2018-v1/MINIAOD",
        # "/JetHT/Run2017C-31Mar2018-v1/MINIAOD",
        # "/JetHT/Run2017D-31Mar2018-v1/MINIAOD",
        # "/JetHT/Run2017E-31Mar2018-v1/MINIAOD",
        # "/JetHT/Run2017F-31Mar2018-v1/MINIAOD"
    ],
    2018: [
        "/EGamma/Run2018A-17Sep2018-v2/MINIAOD",
        "/EGamma/Run2018B-17Sep2018-v1/MINIAOD",
        "/EGamma/Run2018C-17Sep2018-v1/MINIAOD",
        "/EGamma/Run2018D-22Jan2019-v2/MINIAOD",
        # "/JetHT/Run2018A-17Sep2018-v1/MINIAOD",
        # "/JetHT/Run2018B-17Sep2018-v1/MINIAOD",
        # "/JetHT/Run2018C-17Sep2018-v1/MINIAOD",
        # "/JetHT/Run2018D-PromptReco-v2/MINIAOD"
    ]
}

lumiMasks = {
    2016: "https://cms-service-dqm.web.cern.ch/cms-service-dqm/CAF/certification/Collisions16/13TeV/ReReco/Final/Cert_271036-284044_13TeV_ReReco_07Aug2017_Collisions16_JSON.txt",
    2017: "https://cms-service-dqm.web.cern.ch/cms-service-dqm/CAF/certification/Collisions17/13TeV/ReReco/Cert_294927-306462_13TeV_EOY2017ReReco_Collisions17_JSON.txt",
    2018: "https://cms-service-dqm.web.cern.ch/cms-service-dqm/CAF/certification/Collisions18/13TeV/ReReco/Cert_314472-325175_13TeV_17SeptEarlyReReco2018ABC_PromptEraD_Collisions18_JSON.txt"
}

psetFiles = {
    2016: "run_data2016_94X.py",
    2017: "run_data2017_94X.py",
    2018: "run_data2018_102X.py"
}

unitsPerJobSettings = {
    2016: 30,
    2017: 20,
    2018: 15
}

yearsToRun = []
if (inputArguments.year == "2016"):
    yearsToRun.append(2016)
elif (inputArguments.year == "2017"):
    yearsToRun.append(2017)
elif (inputArguments.year == "2018"):
    yearsToRun.append(2018)
elif (inputArguments.year == "all"):
    yearsToRun.append(2016)
    yearsToRun.append(2017)
    yearsToRun.append(2018)
else:
    sys.exit("ERROR: invalid value for argument \"year\": {v}".format(v=inputArguments.year))

def extract_dataset_identifier(dataset):
    splitDataset = dataset.split("/")
    if not(len(splitDataset) == 4):
        sys.exit("dataset: {d} in unexpected format; splitDataset = {s}".format(d=dataset, s=splitDataset))
    return (splitDataset[1] + "_" + splitDataset[2])

# execute_in_crab_env("which crab && type crab")
for year in yearsToRun:
    for dataset in datasets[year]:
        print("Running submission for dataset: {d}".format(d=dataset))
        datasetIdentifier = extract_dataset_identifier(dataset)
        commandToSubmit = ""
        commandToSubmit += "crab submit "
        if (inputArguments.isProductionRun): commandToSubmit += "--wait "
        else: commandToSubmit += "--dryrun "
        storageSite = ""
        if (habitat == "lxplus"):
            storageSite = "T2_CH_CERN"
        else:
            storageSite = "T3_US_FNALLPC"
        lfnDirBase = "{sER}/stealth2018Ntuples_with10210/data_{did}_{v}".format(did=datasetIdentifier, sER=(stealthEOSRoot.replace("user/lpcsusystealth","group/lpcsusystealth")), v=inputArguments.version)
        commandToSubmit += "-c data_crabConfig.py General.requestName=ntuplizer_10210_data_{did} General.workArea=crab_workArea_ntuplizer_10210_data_{did} JobType.psetName={p} Data.inputDataset={d} Data.unitsPerJob={uPJ} Data.lumiMask={lM} Data.outLFNDirBase={lDB} Site.storageSite={sS}".format(did=datasetIdentifier, d=dataset, p=psetFiles[year], lM=lumiMasks[year], sS=storageSite, lDB=lfnDirBase, uPJ=unitsPerJobSettings[year])
        execute_in_crab_env(commandToSubmit)
