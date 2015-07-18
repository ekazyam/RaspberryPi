#!/bin/bash
################################
# Author: Rum Coke
# Data  : 2015/07/18
# Ver   : 0.9.1
################################
# for example.
# Arg 1 on -> GPIO 18 set high
# Arg 1 off-> GPIO 18 set low
# Arg 2 GPIO Number -> 1~n
# GPIO No

################################
# Usage.
################################
function viewUsage()
{
	# View Usage.
	echo "Arg 1 GPIO Number -> 1~n"
	echo "Arg 2  on -> GPIO 18 set high"
	echo "Arg 2 off -> GPIO 18 set low"
	echo ""
	echo "GPIO  on : gpio_switch.sh 18 ${ON}"
	echo "GPIO off : gpio_switch.sh 18 ${OFF}"
}
	
################################
# Status Check.
################################
function checkStatus()
{
	# Arg Check.
	if [ ${STATUS} == ${ON} ]
	then
		# Set high.
		IN_OUT='high'

		return 0
	elif [ ${STATUS} == ${OFF} ]
	then
		# Set low.
		IN_OUT='low'

		return 0
	else
		return 1
	fi
}
	
################################
# GPIO Init.
################################
function initGpio()
{
	# Check Init GPIO
	if [ ! -e ${GPIO_DIS} ]
	then
		# Init GPIO
		echo ${GPIO} > ${GPIO_EXP} 
		echo "in" > ${GPIO_DIS}
	fi
}

################################
# GPIO Switch.
# On or Off.
################################
function switchGpio()
{
	# Switch GPIO
	echo ${IN_OUT} > ${GPIO_DIS}

	# Switch GPIO
	if [ ${STATUS} == ${OFF} ]
	then
		# Unexport
		echo ${GPIO} > ${GPIO_UNEX}
	fi
}

################################
# Main Function
################################
# Arg word.
ON='on'
OFF='off'

# Arg Check
if [ $# -ne 2 ] 
then
	# View Usage.
	viewUsage

	# Not Exist Args.
	exit 1
fi

# Set Args.
GPIO=${1}
STATUS=${2}
IN_OUT=''

# GPIO Direction.
GPIO_DIS="/sys/class/gpio/gpio$GPIO/direction"

# GPIO Export.
GPIO_EXP="/sys/class/gpio/export"

# GPIO Unexport.
GPIO_UNEX="/sys/class/gpio/unexport"

# Status Check.
checkStatus
RESULT=$?

if [ ${RESULT} == 1 ]
then
	# View Usage.
	viewUsage

	# Not Exist Args.
	exit 1
fi

# Init GPIO.
initGpio

# Switch On or Off with GPIO
switchGpio

