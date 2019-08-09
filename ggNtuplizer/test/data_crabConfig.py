from CRABClient.UserUtilities import config
config = config()

# General.requestName, General.workArea, Data.inputDataset, and Data.outLFNDirBase are meant to be passed as arguments to "crab submit"

# To submit:
# for era in B C D E F; do crab submit --dryrun -c data_crabConfig.py General.requestName=re_ntuplizer_949cand2_data_DoubleEG_2017${era} General.workArea=crab_workArea_data_2017${era}_withMETMitigation_newTrigger Data.inputDataset=/DoubleEG/Run2017${era}-31Mar2018-v1/MINIAOD Data.outLFNDirBase=/store/group/lpcsusystealth/stealth2018Ntuples_with949Cand2/data_2017${era}_withMETMitigation_newTrigger/ ; done

config.General.requestName = ""
config.General.workArea = ""
config.General.transferLogs = False

config.JobType.pluginName = "Analysis"
config.JobType.psetName = "run_data2017_94X.py"

config.Data.inputDataset = ""
config.Data.splitting = "LumiBased"
config.Data.unitsPerJob = 15
config.Data.lumiMask = "https://cms-service-dqm.web.cern.ch/cms-service-dqm/CAF/certification/Collisions17/13TeV/ReReco/Cert_294927-306462_13TeV_EOY2017ReReco_Collisions17_JSON.txt"
config.Data.outLFNDirBase = ""
config.Site.storageSite = "T3_US_FNALLPC"
