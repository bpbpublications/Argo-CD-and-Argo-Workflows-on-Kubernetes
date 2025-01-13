# Description: This file contains the setup_repository function which is used to setup a repository

# make above repeatable code into a function
setup_repository() {

  # $1 is the name of the repository
  REPOSITORY_NAME="$1"
  # $2 is the url of the repository
  REPOSITORY_URL="$2"

  # change directory to the echo-service repository
  cd "github-repositories/$REPOSITORY_NAME" || exit

  # remove the .git directory
  rm -rf .git
  # initialize git
  git init

  # add the remote origin
  git remote add origin $REPOSITORY_URL

  # add all files to git
  git add .
  # commit the files
  git commit -a -m  "add source"
  # pull the files from the remote origin
  git pull origin main --rebase || true
  # push the files to the remote origin
  git push -u origin main -f
  # change directory back to the root of the repo
  cd - || exit
}
