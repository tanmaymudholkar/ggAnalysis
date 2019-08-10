#!/bin/bash

BASEHOSTNAME=$(echo $HOSTNAME | sed "s|\([^\.]*\)\.cern\.ch|\1|" | sed "s|\([^\.]*\)\.fnal\.gov|\1|")
NTUPLIZER_SRC=""
export X509_USER_PROXY=${HOME}/private/x509up_u$(id -u)
if [[ "${BASEHOSTNAME}" =~ ^lxplus[0-9]{3,4}$ ]]; then
    NTUPLIZER_SRC="${HOME}/public/research/stealth/from_michael/StealthProduction/CMSSW_9_4_13/src"
elif [[ "${BASEHOSTNAME}" =~ ^cmslpc[0-9]{2}$ ]]; then
    NTUPLIZER_SRC="${HOME}/private/stealth/cmssw/CMSSW_9_4_13/src"
fi
cd ${NTUPLIZER_SRC} && eval `scramv1 runtime -sh`
cd ${NTUPLIZER_SRC}/ggAnalysis/ggNtuplizer/test
source /cvmfs/cms.cern.ch/crab3/crab.sh

set -x

# Comment out selection for submission
crab submit --dryrun -c mc_crabConfig.py General.requestName=ntuplizer_949cand2_mc_Fall17_T5Wg General.workArea=crab_workArea_ntuplizer_949cand2_mc_Fall17_T5Wg Data.inputDataset=/SMS-T5WgStealth_TuneCP2_13TeV-madgraphMLM-pythia8/RunIIFall17MiniAODv2-PUFall17Fast_94X_mc2017_realistic_v15-v1/MINIAODSIM Data.outLFNDirBase=/store/group/lpcsusystealth/stealth2018Ntuples_with949Cand2/MC_Fall17_T5Wg_producedAug19/

crab submit --dryrun -c mc_crabConfig.py General.requestName=ntuplizer_949cand2_mc_Fall17_T6Wg General.workArea=crab_workArea_ntuplizer_949cand2_mc_Fall17_T6Wg Data.inputDataset=/SMS-T6WgStealth_TuneCP2_13TeV-madgraphMLM-pythia8/RunIIFall17MiniAODv2-PUFall17Fast_94X_mc2017_realistic_v15-v1/MINIAODSIM Data.outLFNDirBase=/store/group/lpcsusystealth/stealth2018Ntuples_with949Cand2/MC_Fall17_T6Wg_producedAug19/

crab submit --dryrun -c mc_crabConfig.py General.requestName=ntuplizer_949cand2_mc_Fall17_hgg General.workArea=crab_workArea_ntuplizer_949cand2_mc_Fall17_hgg Data.inputDataset=/GluGluHToGG_M125_13TeV_amcatnloFXFX_pythia8/RunIIFall17MiniAODv2-PU2017_12Apr2018_94X_mc2017_realistic_v14-v1/MINIAODSIM Data.outLFNDirBase=/store/group/lpcsusystealth/stealth2018Ntuples_with949Cand2/MC_Fall17_hgg_producedAug19/

crab submit --dryrun -c mc_crabConfig.py General.requestName=ntuplizer_949cand2_mc_Fall17_EMEnrichedQCD_Pt-30to40 General.workArea=crab_workArea_ntuplizer_949cand2_mc_Fall17_EMEnrichedQCD_Pt-30to40 Data.inputDataset=/QCD_Pt-30to40_DoubleEMEnriched_MGG-80toInf_TuneCP5_13TeV_Pythia8/RunIIFall17MiniAODv2-PU2017_12Apr2018_94X_mc2017_realistic_v14-v1/MINIAODSIM Data.outLFNDirBase=/store/group/lpcsusystealth/stealth2018Ntuples_with949Cand2/MC_Fall17_EMEnrichedQCD_Pt-30to40_producedAug19/

crab submit --dryrun -c mc_crabConfig.py General.requestName=ntuplizer_949cand2_mc_Fall17_EMEnrichedQCD_Pt-30toInf General.workArea=crab_workArea_ntuplizer_949cand2_mc_Fall17_EMEnrichedQCD_Pt-30toInf Data.inputDataset=/QCD_Pt-30toInf_DoubleEMEnriched_MGG-40to80_TuneCP5_13TeV_Pythia8/RunIIFall17MiniAODv2-PU2017_12Apr2018_94X_mc2017_realistic_v14-v1/MINIAODSIM Data.outLFNDirBase=/store/group/lpcsusystealth/stealth2018Ntuples_with949Cand2/MC_Fall17_EMEnrichedQCD_Pt-30toInf_producedAug19/

crab submit --dryrun -c mc_crabConfig.py General.requestName=ntuplizer_949cand2_mc_Fall17_EMEnrichedQCD_Pt-40toInf General.workArea=crab_workArea_ntuplizer_949cand2_mc_Fall17_EMEnrichedQCD_Pt-40toInf Data.inputDataset=/QCD_Pt-40toInf_DoubleEMEnriched_MGG-80toInf_TuneCP5_13TeV_Pythia8/RunIIFall17MiniAODv2-PU2017_12Apr2018_94X_mc2017_realistic_v14-v1/MINIAODSIM Data.outLFNDirBase=/store/group/lpcsusystealth/stealth2018Ntuples_with949Cand2/MC_Fall17_EMEnrichedQCD_Pt-40toInf_producedAug19/

set +x
