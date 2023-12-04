//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"CPU: "  , "top -bn1 | grep Cpu | awk '{print $2}'"                  , 5 , 0} ,

	{"Mem: " , "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g" , 5 , 0} ,

	{""     , "date '+%b %d [%a] %I:%M%p'"                              , 30 , 0} ,
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
