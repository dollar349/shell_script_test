ABSPATH=$(readlink -f "$BASH_SOURCE")
SCRIPTPATH=$(dirname "$ABSPATH")

PRJ_FUNCTION_FILE="${SCRIPTPATH}/prj_image_function.sh"

# Check PRJ_FUNCTION_FILE file exist
if test ! -f ${PRJ_FUNCTION_FILE}; then
    echo "${PRJ_FUNCTION_FILE} not found"
    exit 1
fi
source ${PRJ_FUNCTION_FILE}

copy_image_file