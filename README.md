# PySwitch for Python3

## Introduction

* PySwitch is a simple utility that helps to create and manage Python3 virtual environments.

* It installs all required packages if not present in the system

* Environments can be found in *$HOME/python-environments* directory and can be used as usal with all the other commands *(e.g. deactivate, source .../bin/activate)*.

### Compatible Operating Systems

PySwitch now supports only Linux distros with *apt* package manager.

## Setup

* Open a shell and run the following commands

```
cd ~
git clone https://github.com/Eraz1997/pyswitch.git .pyswitch
sudo ./.pyswitch/install.sh
```

* Then you can:

  * Exit shell and open a new one

  * Or (if you use */bin/bash*)

  ```
  source .bashrc
  ```

  * Or (if you use *zsh*)

  ```
  source .zshrc
  ```

## Usage

### Help

* Open a shell and run

```
pyswitch --help
```

* Each pyswitch command but this will check for required packages and tries to install them if not present in the system.

### Create new environment

* Open a shell and run

```
pyswitch [ENVIRONMENT_NAME] --create
```

* Environment will be create *but not activated in the current shell*.

### Activate environment

* Open a shell and run

```
pyswitch [ENVIRONMENT_NAME]
```

* Current shell will run under the *ENVIRONMENT_NAME* Python3 environment.

* If selected environment is not present, pyswitch will ask if you'll want to create it.

* You can check which is the current environment with

```
pyswitch --current
```

* You can check deactivate current environment with

```
pyswitch --deactivate
```

### Delete environment

* Open a shell and run

```
pyswitch [ENVIRONMENT_NAME] --delete
```

* A confirmation message will be shown, then the selected environment will be deleted (if present).
