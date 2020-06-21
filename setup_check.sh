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
  echo -e "\e[48;5;88m$(date +'%Y-%m-%d %T') ERROR: $1\e[0m $2" 1>&2
  exit 1
}

warning()
{
  echo -e "\e[7m$(date +'%Y-%m-%d %T') WARNING\e[0m $@"
}

usage()
{
  echo -e "
bash $PROGRAM 

Checks if the requirements for the Introduction to Python course are satisfied. 
If not, reports what is missing."
}

modules="numpy pandas matplotlib scipy"

warning "
This is a very simple script that looks for \e[1mPython3\e[0m, \e[1mJupyter lab\e[0m and
Python modules: \e[1m${modules}\e[0m.
It also tries to give you the best advice on how to proceed in case any of them 
are missing.

If you have more than one Python3 version installed adapt the following advice
accordingly, i.e. make sure the PATH is set up properly or conda environment 
is activated before checking, and then installing new Python version :)!

If you do not feel like you understand the advice properly contact the author,
or try running the workshop in Google Colab (more info in the README file).
" 

# Check if Python3 installed
python3_present=$(which python3) 

if [ "${python3_present}" == "" ]; then
  error "Python3 is missing" "
There is no Python3 installation present in your PATH! 
If you are using conda, remember to activate a proper environment."
fi

# Check Python3 minor version
python_version=$(python3 --version | cut -f2 -d' ')
python_version_minor=$(echo ${python_version} | cut -f2 -d'.')

if [ "${python_version_minor}" -lt "5" ]; then
    warning "
Your Python3 version (${python_version}) is a bit old. This course was not tested 
on versions earlier than 3.5.3 and some of its features may not work properly."
fi

# Check for necessary modules
for module in ${modules}; do
    fail=true;
    python3 -c "import $module" 2> /dev/null && fail=false;
    if ${fail}; then
        modules_to_install="${modules_to_install} $module"
    fi
done

modules_to_install=$(echo ${modules_to_install} | tr -s ' ' | sed 's/^ //g')
  
pip3_present=$(which pip3)
conda_present=$(which conda)

if [ "${modules_to_install}" != "" ]; then
    if [ "${conda_present}" != "" ]; then
        error "Missing module(s)" "
\e[31mThe following module(s) are missing:\e[0m 
  \e[1m${modules_to_install}\e[0m 
In order to install them, for example activate desired environment 
  \e[1mconda activate desired_environment\e[0m
and install packages: 
  \e[1mconda install -c anaconda ${modules_to_install}\e[0m"
    elif [ "${pip3_present}" != "" ]; then
        error "Missing module(s)" "
\e[31mThe following module(s) are missing:\e[0m 
  \e[1m${modules_to_install}\e[0m 
In order to install them try typing:
  \e[1mpip3 ${modules_to_install}\e[0m"
    else        
        error "Missing module(s)" "
\e[31mThe following module(s) are missing:\e[0m 
  \e[1m${modules_to_install}\e[0mi"
    fi
fi

# Lastly, check for the Jupyter notebook
jupyter lab -h > /dev/null 2>&1 && jupyter_notebook="present"

if [ "${jupyter_notebook}" == "" ]; then
    if [ "${pip3_present}" != "" ] || [ "${conda_present}" != "" ]; then
        error "Jupyter lab is missing" "
You can install jupyter lab with conda (remember to switch the environment on)
  \e[1mconda install -c anaconda jupyterlab\e[0m
If you are not using conda, try typing 
  \e[1mpip3 install jupyter\e[0m"
    else
        error "Jupyter lab missing" "
No conda, nor pip3 detected. Follow the installation guide here: 
https://jupyterlab.readthedocs.io/en/stable/getting_started/installation.html"
    fi
fi

if [ "$(which cowsay)" != "" ]; then
  cowsay "Success! Seems like all modules are installed! 
  You are ready to start the workshop. Hope you'll enjoy it! :)"
else 
  echo -e "
=================================== SUCCESS ====================================
| Seems like all modules are installed! You are ready to start the workshop.   |
| Hope you'll enjoy it! :)                                                     |
|                                                                              |
| BTW. If you would have cowsay installed this message would be way nicer.     |
| You can install it by typing: \e[1msudo apt install cowsay\e[0m, just saying ;)        |
================================================================================
"
fi
