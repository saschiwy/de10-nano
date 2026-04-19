
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOCKER_PATH="$( realpath "${SCRIPT_PATH}" )"
REPO_PATH="$( realpath "${SCRIPT_PATH}" )"

docker build -t yocto -f "${DOCKER_PATH}"/Dockerfile_yocto "${REPO_PATH}"