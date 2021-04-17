from CRABClient.UserUtilities import config
config = config()

config.General.requestName = ""
config.General.workArea = ""
config.General.transferLogs = False

config.JobType.pluginName = "Analysis"
config.JobType.psetName = ""
config.JobType.allowUndistributedCMSSW = True

config.Data.inputDataset = ""
config.Data.splitting = "LumiBased"
config.Data.unitsPerJob = 15
config.Data.lumiMask = ""
config.Data.outLFNDirBase = ""
config.Site.storageSite = ""
