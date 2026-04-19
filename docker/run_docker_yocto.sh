# Run docker interactive with mount on first script argument
# Check if the first argument is a directory
# If it is not, print an error message and exit

if [ ! -d "$1" ]; then
    echo "Error: $1 is not a directory"
    exit 1
fi


docker run --rm -it --mount type=bind,source=$1,target=/yocto yocto