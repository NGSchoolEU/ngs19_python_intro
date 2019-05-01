#!/bin/bash
# ==============================================================================
# | Description:   Checks if requirements for the Intro to Python class        |
# |                are satisfied.                                              |
# | Author:        Katarzyna Kedzierska                                        |
# | Affiliation:   Wellcome Centre for Human Genetics, University of Oxford    |
# | Date:          April 30, 2019                                              |
# | Usage:         bash check_setup.sh                                         |
# ==============================================================================

PROGRAM=$0

# Defining helper functions
error()
{
  echo -e "$(date +'%Y-%m-%d %T') ERROR: $@" 1>&2
  exit 1
}

warning()
{
  echo -e "$(date +'%Y-%m-%d %T') WARNING: $@"
}

usage()
{
  echo -e "
bash $PROGRAM 

Checks if the requirements for the Introduction to Python course are satisfied. 
If not, reports what is missing."
}

modules="numpy pandas matplotlib scipy"

warning "This is a very simple script that looks for Python3 and required 
modules ($modules). If you have more than one Python3 version installed adapt 
the following advices accordingly (for example - make sure the PATH is set up 
properly or conda environment is activated before installing new Python 
version ;))!" 

# Check if Python3 installed
python3_present=$(which python3) 

if [ "${python3_present}" == "" ]; then
  error "There is no Python3 installation present in your PATH! 
  If you are using conda, rember to activate a proper environment."
fi

# Check Python3 minor version
python_version=$(python3 --version | cut -f2 -d' ')
python_version_minor=$(echo ${python_version} | cut -f2 -d'.')

if [ "${python_version_minor}" -lt "5" ]; then
    warning "Your Python3 version (${python_version}) is a bit old. 
    This course was not tested on versions earlier than 3.5.3 and some of its 
    features may not work properly."
fi

# Check for necessary modules
for module in ${modules}; do
    fail=true;
    python3 -c "import $module" 2> /dev/null && fail=false;
    if ${fail}; then
        modules_to_install="${modules_to_install} $module"
    fi
done
  
pip3_present=$(which pip3)

if [ "${modules_to_install}" != "" ]; then
    if [ "${pip3_present}" != "" ]; then
        error "The following modules are missing: ${modules_to_install}\n
        In order to install them try typing pip3 ${modules_to_install} into 
        your terminal."
    else
        error "The following modules are missing: ${modules_to_install}"
    fi
fi

# Lastly, check for the Jupyter notebook
jupyter notebook -h > /dev/null && jupyter_notebook="present"

if [ "${jupyter_notebook}" == "" ]; then
    if [ "${pip3_present}" != "" ]; then
        error "Jupyter notebook is missing. Jupyter comes with Anaconda, 
        so if you have conda installed, remember to activate the environment 
        properly! 
        If you are not using conda, try typing \`pip3 install jupyter\` 
        into the command line."
    else
        error "Jupyter notebook is missing. Jupyter comes with Anaconda, 
        so if you have conda installed, remember to activate the environment 
        properly!"
    fi
fi

if [ "$(which cowthink)" != "" ]; then
  cowsay "Success! Seems like all modules are installed! 
  You are ready to start the workshop. Hope you'll enjoy it! :)"
else 
  echo "
=================================== SUCCESS ====================================
| Seems like all modules are installed! You are ready to start the workshop.   |
| Hope you'll enjoy it! :)                                                     |
|                                                                              |
| BTW. If you would have cowsay installed this message would be way nicer.     |
| You can install it by typing: sudo apt install cowsay, just saying ;)        |
================================================================================
"
fi
