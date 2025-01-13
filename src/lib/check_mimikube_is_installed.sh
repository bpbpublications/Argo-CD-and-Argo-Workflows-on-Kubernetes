## Add any function here that is needed in more than one parts of your
## application, or that you otherwise wish to extract from the main function
## scripts.
##
## Note that code here should be wrapped inside bash functions, and it is
## recommended to have a separate file for each function.
##
## Subdirectories will also be scanned for *.sh, so you have no reason not
## to organize your code neatly.
##
check_mimikube_is_installed() {

  echo "checking mimikube is installed"
  # check if minikube is installed
  if ! command -v minikube >/dev/null 2>&1; then
    echo "minikube is not installed"
    exit 1
  fi
}

