## Python

A Tic-Tac-Toe game written using Python.

### Requirements

#### Language
Check to see if Node is installed by running `python --version` on the command line. If the command isn't recognized, then download Python and try the command again.

#### Linting
If you're using VS Code, then install the [Python extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python).

### Setup

#### CLI 

1. `cd` into the `Python/` directory.
2. Run the app using `python -m tic_tac_toe`.

#### VS Code

1. Run the app using the `Python` VS Code launch action.

### Overview 

The `tic_tac_toe` folder is a Python package, which is recognized by the .... Running a package will run the `__main__.py` file automatically. 

Python packages are recognized by their `__init__.py` file, even if the file is empty. If you're running the program in a terminal, then pass `-m` to signify that you're running a module. If you want to run a single file, then you can just run `python <file-name>.py`