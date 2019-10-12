#!/bin/bash

BASEHOSTNAME=$(echo $HOSTNAME | sed "s|\([^\.]*\)\.cern\.ch|\1|" | sed "s|\([^\.]*\)\.fnal\.gov|\1|")
${STEALTH_CMSSW_BASE}
cd ${STEALTH_CMSSW_BASE}/src && eval `scramv1 runtime -sh`
cd ${STEALTH_CMSSW_BASE}/src/ggAnalysis/ggNtuplizer/test
source /cvmfs/cms.cern.ch/crab3/crab.sh

DRYRUNFLAG="--dryrun "
if [ "${1}" = "prod" ]; then
    DRYRUNFLAG=""
fi

set -x

# Comment out selection for submission
# crab submit ${DRYRUNFLAG}-c mc_crabConfig.py General.requestName=ntuplizer_10210_mc_Fall17_stealth_T5Wg General.workArea=crab_workArea_ntuplizer_10210_mc_Fall17_stealth_T5Wg Data.inputDataset=/SMS-T5WgStealth_TuneCP2_13TeV-madgraphMLM-pythia8/RunIIFall17MiniAODv2-PUFall17Fast_94X_mc2017_realistic_v15-v1/MINIAODSIM Data.outLFNDirBase=/store/group/lpcsusystealth/stealth2018Ntuples_with10210/MC_Fall17_stealth_T5Wg_producedAug19/

# crab submit ${DRYRUNFLAG}-c mc_crabConfig.py General.requestName=ntuplizer_10210_mc_Fall17_stealth_T6Wg General.workArea=crab_workArea_ntuplizer_10210_mc_Fall17_stealth_T6Wg Data.inputDataset=/SMS-T6WgStealth_TuneCP2_13TeV-madgraphMLM-pythia8/RunIIFall17MiniAODv2-PUFall17Fast_94X_mc2017_realistic_v15-v1/MINIAODSIM Data.outLFNDirBase=/store/group/lpcsusystealth/stealth2018Ntuples_with10210/MC_Fall17_stealth_T6Wg_producedAug19/

# crab submit ${DRYRUNFLAG}-c mc_crabConfig.py General.requestName=ntuplizer_10210_mc_Fall17_hgg General.workArea=crab_workArea_ntuplizer_10210_mc_Fall17_hgg Data.inputDataset=/GluGluHToGG_M125_13TeV_amcatnloFXFX_pythia8/RunIIFall17MiniAODv2-PU2017_12Apr2018_94X_mc2017_realistic_v14-v1/MINIAODSIM Data.outLFNDirBase=/store/group/lpcsusystealth/stealth2018Ntuples_with10210/MC_Fall17_hgg_producedAug19/

# crab submit ${DRYRUNFLAG}-c mc_crabConfig.py General.requestName=ntuplizer_10210_mc_Fall17_EMEnrichedQCD_Pt-30to40 General.workArea=crab_workArea_ntuplizer_10210_mc_Fall17_EMEnrichedQCD_Pt-30to40 Data.inputDataset=/QCD_Pt-30to40_DoubleEMEnriched_MGG-80toInf_TuneCP5_13TeV_Pythia8/RunIIFall17MiniAODv2-PU2017_12Apr2018_94X_mc2017_realistic_v14-v1/MINIAODSIM Data.outLFNDirBase=/store/group/lpcsusystealth/stealth2018Ntuples_with10210/MC_Fall17_EMEnrichedQCD_Pt-30to40_producedAug19/

# crab submit ${DRYRUNFLAG}-c mc_crabConfig.py General.requestName=ntuplizer_10210_mc_Fall17_EMEnrichedQCD_Pt-30toInf General.workArea=crab_workArea_ntuplizer_10210_mc_Fall17_EMEnrichedQCD_Pt-30toInf Data.inputDataset=/QCD_Pt-30toInf_DoubleEMEnriched_MGG-40to80_TuneCP5_13TeV_Pythia8/RunIIFall17MiniAODv2-PU2017_12Apr2018_94X_mc2017_realistic_v14-v1/MINIAODSIM Data.outLFNDirBase=/store/group/lpcsusystealth/stealth2018Ntuples_with10210/MC_Fall17_EMEnrichedQCD_Pt-30toInf_producedAug19/

# crab submit ${DRYRUNFLAG}-c mc_crabConfig.py General.requestName=ntuplizer_10210_mc_Fall17_EMEnrichedQCD_Pt-40toInf General.workArea=crab_workArea_ntuplizer_10210_mc_Fall17_EMEnrichedQCD_Pt-40toInf Data.inputDataset=/QCD_Pt-40toInf_DoubleEMEnriched_MGG-80toInf_TuneCP5_13TeV_Pythia8/RunIIFall17MiniAODv2-PU2017_12Apr2018_94X_mc2017_realistic_v14-v1/MINIAODSIM Data.outLFNDirBase=/store/group/lpcsusystealth/stealth2018Ntuples_with10210/MC_Fall17_EMEnrichedQCD_Pt-40toInf_producedAug19/

set +x
