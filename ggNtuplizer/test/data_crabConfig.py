from CRABClient.UserUtilities import config
config = config()

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
