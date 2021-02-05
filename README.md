# Clak10AdditionalFunctions
Some additional functions for PowerShell

## Stop-SelectProcess

### SYNOPSIS
    Kills processes running on the local computer specified by the search parameter.
### DESCRIPTION
    Locate and list processes running on the local computer that contain the search parameter in their name. 
    It then ask for confirmation to kills one or all the processes listed. 
    Useful when an application is run multiple processes or when you are not sure of the name of the process you want to stop.
### PARAMETERS
    -SearchString <String>
        Specifies the string to use for search.
### EXAMPLE
    Stop-SelectProcess chrome
    Name     PID     CPU(mb) Path
    ----     ---     ------- ----
    chrome 17876  0.01128125 C:\Program Files (x86)\Google\Chrome 
    chrome 16520 0.011046875 C:\Program Files (x86)\Google\Chrome
    chrome  2776 0.000171875 C:\Program Files (x86)\Google\Chrome 
    Enter an PID from the list above or 'a' to kill all: 2776
    Done

## Head
### SYNOPSIS
    Displays a specified number of lines from the beginning of a file.
### DESCRIPTION
    Prints to screen a specified number of lines from the beginning of a file. By default, it prints the first 5 lines of the specified files.
### PARAMETERS
    -Path <String>
        The path of the file.
    -Lines <long>
        The number of lines to print. Default is 5 lines
### EXAMPLE 1
    Head C:\Users\user\Documents\test.txt
    This is a line 1
    This is a line 2
    This is a line 3
    This is a line 4
    This is a line 5
### EXAMPLE 2
    Head C:\Users\user\Documents\test.txt -Lines 10
    This is a line 1
    This is a line 2
    This is a line 3
    This is a line 4
    This is a line 5
    This is a line 6
    This is a line 7
    This is a line 8
    This is a line 9
    This is a line 10

## Tail
### SYNOPSIS
    Displays a specified number of lines from the beginning of a file.
### DESCRIPTION
    Prints to screen a specified number of lines from the beginning of a file. By default, it prints the first 5 lines of the specified files.
### PARAMETERS
    -Path <String>
        The path of the file.
    -Lines <long>
        The number of lines to print. Default is 5 lines
### EXAMPLE
    Tail C:\Users\user\Documents\test.txt
    This is a line 6
    This is a line 7
    This is a line 8
    This is a line 9
    This is a line 10
### EXAMPLE
    Tail C:\Users\user\Documents\test.txt -Lines 10
    This is a line 1
    This is a line 2
    This is a line 3
    This is a line 4
    This is a line 5
    This is a line 6
    This is a line 7
    This is a line 8
    This is a line 9
    This is a line 10
