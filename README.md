# TurtleHTTP

-Turtle HTTP Git repo management and MineCraft Turtle's make-shift git access to data.

## 111 ### ### ###

**USAGE:**

    (1) Run 'single_script.bat'. Accomplishes 1.1 and 1.2.

        (Alternative:)

        (1.1) Run 'listdir_shell_script.bat' to generate an updated .json.

        (1.2) Run 'Gitpython_init.bat' to push updated repo to Git.

    (2) In MineCraft, execute 'gitFetch3_iter.lua' to retrieve all the \miners\ programs.

## /1/ ### ### ###

## 222 ### ### ###

**INSIDE THIS GIT REPO:**

_\TurtleHTTP\_listdir\_

-SCRIPTS:

    -.bats:

        - 'listdir_shell_script.bat' -- Runs the list_dir_miners_list.py script.

        - 'Gitpython_init.bat' -- Runs the Gitpython_init_02.py script.

    -.pys:

        - 'list_dir_miners_list.py' -- Generates the cc_dir_miners_list.json from %HOMEPATH%\Documents\GitHub\TurtleHTTP\computercraft_dir\miners\

        - 'Gitpython_init_02.py' -- Checks the TurtleHTTP git repo for new untracked files and for diffed files; adds/updates them to the repo; pushes updates.

-GENERATED:

    - 'cc_dir_miners_list.json' -- .json file for MineCraft Turtle's to download and refer to. Contains program names for generating all the HTTP download requests.

_\computercraft_dir\miners\_

    - '_fromNN.txt' -- Debugging/development reference of which computer## these lua scripts are from. list_dir_miners_list.py ignores this file ('_' hides it.)

    - 'trtPos.txt' -- Turtle's location info. [integers]: x, y, z, [booleans]: n, s, e, w, [string]: 'direction'

    - '*.lua' -- Turtle scripts.

        - 'gps_test3_local_init.lua' -- FUNCTION: Determine coordinates and cardinal direction. Uses gps.locate to get coordinates, and determines direction by moving one space forward and comparing the change in coordinates.

        - 'modemrcv1.lua' -- FUNCTION: Modem receive script. Waits for a GPS location transmission from another Turtle, and then moves to it. Waits for ser6modem.lua to transmit a location.

        - 'ser6modem.lua' -- FUNCTION: Modem transmit script. Takes the Turtle's personal location and transmits its coordinates to a Turtle with modemrcv1.lua running, summoning the receiving Turtle to the transmitted coordinates.

        - 'serialize1_init.lua' -- FUNCTION: Manual input a Turtle's x, y, z, and cardinal direction.

        - 'serialize4recall.lua' -- FUNCTION: Read the trtPos.txt file and output the x, y, z, and direction.

        - 'transitPosSer2.lua' -- FUNCTION: Transit the turtle (x, y, z) steps from where its located. Serializes afterward.

        - 'transitRawSer4.lua' -- FUNCTION: Transit the turtle to the specific location (x, y, z). Turtle will determine the number of steps needed to arrive at that location. Serializes afterward.

## /2/ ### ### ###



## 333 ### ### ###

**INSIDE MINECRAFT:**

_\computercraft\computer\##\_

    'gitFetch3_iter.lua' -- Command the Turtle to fetch all of the *.lua Turtle scripts. Accesses the cc_dir_miners_list.json and uses it to generate http.get() requests for each file.

## /3/ ### ### ###