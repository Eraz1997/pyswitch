#!/bin/bash

if [ $# -lt 1 ] || [ "$1" = "--help" ] || [ "$2" = "--help" ]; then
	echo "Python Environment Switcher"
	echo "It activates environments located in $HOME/python-environments/"
	echo
	echo "Usage: 'pyswitch [ENVIRONMENT] [OPTIONS]' or 'pyswitch deactivate'"
	echo
	echo "Options: --create --delete --help"
else

	if [ ! -d "$HOME/python-environments" ]; then
		mkdir "$HOME/python-environments"
		echo
		echo "First time launching... Setup complete."
	fi

	if ! command -v deactivate &> /dev/null ; then
		if ! command -v python3 &> /dev/null ; then
			echo "Python is not installed. Installing now..."
			sudo apt update
			sudo apt install python3
		fi
		if ! command -v pip3 &> /dev/null ; then
			echo "Pip is not installed. Installing now..."
			sudo apt update
			sudo apt install python3-pip
		fi
		if ! pip3 list 2> /dev/null | grep "virtualenv" > /dev/null ; then
			echo "Virtualenv is not installed. Installing now..."
			pip3 install virtualenv
		fi
	fi

	if [ $# = 1 ] && [ "$1" = "deactivate" ]; then
		if command -v deactivate &> /dev/null ; then
			deactivate
			echo "Environment deactivated. Now using $(which python3)."
		else
			echo "No environment is currently checked."
		fi
	elif [ $# = 1 ]; then
		if [ ! -d "$HOME/python-environments/$1" ] || [ ! -d "$HOME/python-environments/$1/bin" ] || [ ! -f "$HOME/python-environments/$1/bin/activate" ]; then
			echo -n "Environment $1 does not exist. Do you wish to create it (y/n)? "
			read choice
			while [ "$choice" != "y" ] && [ "$choice" != "Y" ] && [ "$choice" != "n" ] && [ "$choice" != "N" ]
			do
				echo -n "Please select valid option (y/n): "
				read choice
			done
			if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
				if command -v deactivate &> /dev/null ; then
					deactivate
				fi
				if [[ "$1" =~ "/[^a-zA-Z0-9_\-]+/g" ]]; then
					echo "Only alphanumeric values and \"-\" or \"_\" symbols are allowed."
				else
					python3 -m venv "$HOME/python-environments/$1"
					source "$HOME/python-environments/$1/bin/activate"
					echo "Created and selected Python environment $1"
				fi
			fi
		else
			if command -v deactivate &> /dev/null ; then
				deactivate
			fi
			source "$HOME/python-environments/$1/bin/activate"
			echo "Switched to Python environment $1"
		fi
	elif [ "$2" = "--create" ] && [ $# = 2 ]; then
		if [ -d "$HOME/python-environments/$1" ]; then
			echo "Environment already present."
		elif [[ "$1" =~ "/[^a-zA-Z0-9_\-]+/g" ]]; then
			echo "Only alphanumeric values and \"-\" or \"_\" symbols are allowed."
		else
			python3 -m venv "$HOME/python-environments/$1"
			echo "Created Python environment $1"
		fi
	elif [ "$2" = "--delete" ] && [ $# = 2 ]; then
		if [ ! -d "$HOME/python-environments/$1" ]; then
			echo "Environment $1 does not exist."
		else
			echo -n "Are you really sure to delete environment $1? (y/n) "
			read choice
			while [ "$choice" != "y" ] && [ "$choice" != "Y" ] && [ "$choice" != "n" ] && [ "$choice" != "N" ]
		       	do
		                echo -n "Please select valid option (y/n): "
		        	read choice
			done
			if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
				if command -v deactivate &> /dev/null ; then
					deactivate
				fi
				rm -r "$HOME/python-environments/$1"
				echo "Deleted environment $1"
			fi
		fi
	else
		echo "Invalid option. See --help"
	fi
fi
