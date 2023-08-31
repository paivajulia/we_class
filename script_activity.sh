#! /bin/sh

PROGNAME=$0

: "
For help with this script see usage() 
"


# function for error
usage() {
  cat << EOF >&2
	Usage: $PROGNAME [-f <file>] [-n <number>]
	-f <file>: The file to read the line from
 	-n <number>: The line number to print to standard output
EOF
  exit 1
}

# read in args with getopts
while getopts f:n: o; do
	case $o in
		f) file=$OPTARG;;
		n) number=$OPTARG;;
		*) usage
	esac
done

# add condition to make sure number is an integer or print usage
if [[ ! "$number" =~ ^[0-9]+$ && $number -eq $number ]]; then 
	usage
fi

# add condition to check if file exists or print usage
if [ ! -f "$file" ]; then
	usage
fi

# add condition to make sure the integer is within range of file line numbers or print usage
nlines=$(wc -l < "$file")
if [ $number -gt $nlines ]; then
	usage
fi

# do the task...
head $file -n$number | tail -n1
exit 0
