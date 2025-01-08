#!/bin/bash

# ***************************************************************************************
#
# See: https://sourceforge.net/p/ledspicer/wiki/Emulation%20Station%20Integration/
#
# Replace in /etc/emulationsation/es_systems.cfg
#   i.e.:
#    /opt/retropie/supplementary/runcommand/runEmulator.sh mame-mame4all %ROM%  "%BASENAME%" arcade
#    OR
#    /opt/retropie/supplementary/runcommand/runEmulator.sh n64 %ROM% "%BASENAME%" n64
#
# ***************************************************************************************

#    $1 - the system (eg: atari2600, nes, snes, megadrive, fba, etc).
#    $2 - Rom path
#    $3 - Rom name
#    $4 - Platform (arcade, generic, etc)


SYSTEM=$1
ROM_PATH=$2
ROM_NAME=$3
PLATFORM=$4

#echo $SYSTEM
#echo $ROM_PATH
#echo $ROM_NAME
#echo $PLATFORM

if [[ "$PLATFORM" == "mame" ||  "$PLATFORM" == "arcade" ]];
then
    # SET all arcades to 4-way joystick 
    # TODO need to be more discriment on this.
    # echo "SETTING joystick to 4-way"
    rotator 1 1 4
    rotator 2 1 4
else
    # echo "SETTING joystick to 8-way"
    rotator 1 1 8
    rotator 2 1 8
fi

emitter LoadProfileByEmulator "$ROM_NAME" systems/$PLATFORM > /dev/null 2>&1

/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ $SYSTEM "$ROM_PATH"

emitter FinishLastProfile > /dev/null 2>&1

# echo
# echo

exit 0
