### TurtleHTTP
-Turtle HTTP Git repo management and MineCraft Turtle's make-shift git access to data.

### ### 111 ### ###
USAGE:
    (1) Run "single_script.bat". Accomplishes 1.1 and 1.2.
        (Alternative:)
        (1.1) Run "listdir_shell_script.bat" to generate an updated .json.
        (1.2) Run "Gitpython_init.bat" to push updated repo to Git.
    (2) In MineCraft, execute "gitFetch3_iter.lua" to retrieve all the \miners\ programs.
### ### /1/ ### ###

### ### 222 ### ###
INSIDE THIS GIT REPO:
\TurtleHTTP\_listdir\
-SCRIPTS:
--.bats:
    listdir_shell_script.bat -- Runs the list_dir_miners_list.py script.
    Gitpython_init.bat -- Runs the Gitpython_init_02.py script.
--.pys:
    list_dir_miners_list.py -- Generates the cc_dir_miners_list.json from %HOMEPATH%\Documents\GitHub\TurtleHTTP\computercraft_dir\miners\
    Gitpython_init_02.py -- Checks the TurtleHTTP git repo for new untracked files and for diffed files; adds/updates them to the repo; pushes updates.

-GENERATED:
    cc_dir_miners_list.json -- .json file for MineCraft Turtle's to download and refer to. Contains program names for generating all the HTTP download requests.

\computercraft_dir\miners\
    _fromNN.txt -- Debugging/development reference of which computer## these lua scripts are from. list_dir_miners_list.py ignores this file ('_' hides it.)
    *.lua -- Turtle scripts.
    trtPos.txt -- Turtle's location info. [integers]: x, y, z, [booleans]: n, s, e, w, [string]: 'direction'
### ### /2/ ### ###



### ### 333 ### ###
INSIDE MINECRAFT:
\computercraft\computer\##\
    gitFetch3_iter.lua -- Command the Turtle to fetch all of the *.lua Turtle scripts. Accesses the cc_dir_miners_list.json and uses it to generate http.get() requests for each file.
### ### /3/ ### ###