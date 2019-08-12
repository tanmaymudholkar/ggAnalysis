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

CRAB_CONFIG_FILE=""
REQUESTNAME_SUFFIX=""
WORKAREA_SUFFIX=""
INPUT_DATASET=""
OUTPUT_DIRECTORY=""
UNITS_PER_JOB=""
DRYRUNFLAG="--dryrun "

parse_single_argument() {
    if [ "$#" -ne 1 ]; then
        echo "parse_single_argument has an unexpected number of parameters. List of all parameters:"
        echo "$@"
        exit 1
    fi
    INPUT_ARG_NAME=`echo ${1} | cut --only-delimited --delimiter="=" --fields=1`
    INPUT_ARG_VALUE=`echo ${1} | cut --only-delimited --delimiter="=" --fields=2`
    case "${INPUT_ARG_NAME}" in
        configFile)
            CRAB_CONFIG_FILE="${INPUT_ARG_VALUE}"
            ;;
        requestSuffix)
            REQUESTNAME_SUFFIX="${INPUT_ARG_VALUE}"
            ;;
        workareaSuffix)
            WORKAREA_SUFFIX="${INPUT_ARG_VALUE}"
            ;;
        inputDataset)
            INPUT_DATASET="${INPUT_ARG_VALUE}"
            ;;
        outputDirectory)
            OUTPUT_DIRECTORY="${INPUT_ARG_VALUE}"
            ;;
        unitsPerJob)
            UNITS_PER_JOB="${INPUT_ARG_VALUE}"
            ;;
        dryRunFlag)
            if [ "${INPUT_ARG_VALUE}" = "0" ]; then
                DRYRUNFLAG=""
            else
                echo "argument dryRunFlag only accepts value 0"
                exit 1
            fi
            ;;
        *)
            echo "Unexpected argument: "
            echo "${1}"
            exit 1
    esac
}

for arg in "$@"; do parse_single_argument "${arg}"; done

set -x
crab submit ${DRYRUNFLAG}-c ${CRAB_CONFIG_FILE} General.requestName=ntuplizer_9413_${REQUESTNAME_SUFFIX} General.workArea=crab_workArea_ntuplizer_9413_${WORKAREA_SUFFIX} Data.inputDataset=${INPUT_DATASET} Data.unitsPerJob=${UNITS_PER_JOB} Data.outLFNDirBase=/store/group/lpcsusystealth/stealth2018Ntuples_with9413/${OUTPUT_DIRECTORY}
set +x
