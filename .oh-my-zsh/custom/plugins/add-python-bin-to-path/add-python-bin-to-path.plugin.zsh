# Add the `.bin` folder to the PATH

PYTHON_VERSION=$(pip3 -V | cut -f6 -d" " | cut -c 1-3)
PYTHON_BIN_DIR="${HOME}/Library/Python/${PYTHON_VERSION}/bin"
[ -d $PYTHON_BIN_DIR ] && export PATH="${PATH}:${PYTHON_BIN_DIR}"
