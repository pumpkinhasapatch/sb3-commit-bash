#!/bin/bash

# sb3-commit-bash Copyright 2023 pumpkinhasapatch, MIT License. Based on the Windows Batch version by RokCoder-scratch
# HIGHLY RECOMMENDED: See README.md for full instructions and details
#
# Reliancies are:
#   - Any Linux distribution with GNU coreutils
#   - 'unzip' command, included in most distros but may need to be manually installed - sudo dnf/yum install perl-IO-Compress
#   - GitHub Desktop Linux Fork installed from .deb, .rpm or package manager - https://github.com/shiftkey/desktop#readme
# Bash script may need modifying if alternatives are used
#
# Brief overview:
#   - 1) Set PROJECT to the project id of your Scratch project - set to RokCoder's Beeb Emulator by default (531881458)
#   - 2) A modern web browser installed and DOWNLOAD set to the place where it saves files (uses RokCoder's website to convert projects)
#   - 3) Make sure you have GitHub Desktop installed and on the PATH
#   - 4) Change to the project directory, give execute permission with 'sudo chmod +x ./commit.sh' and run this script to see the magic happen...

PROJECT=531881458
DOWNLOAD="/home/$USER/Downloads"

echo Clearing files and folders from previous execution
# Ensure we aren't going to save over an existing file as the download would then be called "$PROJECT (1)" or similar
rm "$DOWNLOAD/$PROJECT.zip"

# Clean out any existing folders used by this process. We need to do this otherwise files that have been removed will not be removed from the repository
rm ../scripts/*

echo Parsing project at rokcoder.com/sb3-to-txt
# Invokes the extraction and conversion process in a web browser (which downloads a single zip file when done)
xdg-open https://www.rokcoder.com/sb3-to-txt?projectId=$PROJECT # \&autosave

# Check Downloads folder every 5 seconds until the zip file has landed
until test -f "$DOWNLOAD/$PROJECT.zip"; do sleep 5; done

# Extracts the textified scripts into ./scripts/
unzip $DOWNLOAD/$PROJECT -d ..

# Remove zip from Downloads folder
rm $DOWNLOAD/$PROJECT.zip

echo Relocating parsed scripts and assets to correct folders
# Fire up GitHub Desktop
github ..

# And we're done!
exit
