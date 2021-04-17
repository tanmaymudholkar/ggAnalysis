from CRABClient.UserUtilities import config
config = config()

config.General.requestName = ""
config.General.workArea = ""
config.General.transferLogs = False

config.JobType.pluginName = "Analysis"
config.JobType.psetName = "run_mc2017_94X.py"
config.JobType.allowUndistributedCMSSW = True

config.Data.inputDataset = ""
config.Data.splitting = "FileBased"
config.Data.unitsPerJob = 1
config.Data.outLFNDirBase = ""
config.Site.storageSite = "T3_US_FNALLPC"
