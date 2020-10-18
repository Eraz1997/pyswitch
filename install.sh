#!/bin/bash

echo "[+] PySwitch installation started"

echo -ne "[ ] Checking root permissions...\r"
if [ "$EUID" -ne 0 ]; then
  echo "[-] Root permissions check failed. Please run with \"sudo\" command"
  exit
fi
echo "[+] Root permissions checked    "

echo -ne "[ ] Disabling virtualenvs if present...\r"
if command -v deactivate &> /dev/null ; then
  deactivate
  echo "[+] Virtualenvs disabled               "
else
  echo "[-] No virtualenv found. Skipping.     "
fi

echo -ne "[ ] Checking Python3 installation...\r"
if ! command -v python3 &> /dev/null ; then
  echo -ne "[ ] Checking Python3 installation... Installing...\r"
  sudo apt update
  sudo apt install python3 -y
  echo "[+] Python3 installed                  "
else
  echo "[-] Python3 already installed       "
fi

echo -ne "[ ] Checking Pip installation...\r"
if ! command -v pip3 &> /dev/null ; then
  echo -ne "[ ] Checking Pip installation... Installing...\r"
  sudo apt update
  sudo apt install python3-pip -y
  echo "[+] Pip installed                                 "
else
  echo "[-] Pip already installed           "
fi

echo -ne "[ ] Checking Virtualenv installation...\r"
if ! pip3 list 2> /dev/null | grep "virtualenv" > /dev/null ; then
  echo -ne "[ ] Checking Virtualenv installation... Installing..."
  pip3 install virtualenv
  echo "[+] Virtualenv installed                               "
else
  echo "[-] Virtualenv already installed        "
fi

echo -ne "[ ] Creating virtual environments folder...\r"
if [ ! -d "$HOME/python-environments" ]; then
  mkdir "$HOME/python-environments"
  echo "[+] Virtual environments folder created         "
else
  echo "[-] Virtual environment folder already present"
fi

echo -ne "[ ] Creating alias for command \"pyswitch\"...\r"
if [ -f "$HOME/.zshrc" ]; then
  echo -ne "[ ] Creating alias for command \"pyswitch\"... Found zsh shell...\r"
  if ! cat .zshrc | grep "alias pyswitch=\"source $HOME/.pyswitch/pyswitch.sh\"" &> /dev/null ; then
    echo "\nalias pyswitch=\"source $HOME/.pyswitch/pyswitch.sh\"" >> .zshrc
    echo "[+] Alias created                                                   "
  else
    echo "[-] Alias already present                                           "
  fi
else
  echo -ne "[ ] Creating alias for command \"pyswitch\"... Using /bin/bash...\r"
  if ! cat .bashrc | grep "alias pyswitch=\"source $HOME/.pyswitch/pyswitch.sh\"" &> /dev/null ; then
    echo "\nalias pyswitch=\"source $HOME/.pyswitch/pyswitch.sh\"" >> .bashrc
    echo "[+] Alias created                                                   "
  else
    echo "[-] Alias already present                                           "
  fi
fi

echo
echo "Success. Reload terminal to apply changes."
