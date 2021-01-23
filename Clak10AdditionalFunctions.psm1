<#
.SYNOPSIS
    Kills processes running on the local computer specified by the search parameter.

.DESCRIPTION
    Locate and list processes running on the local computer that contain the search parameter in their name. 
    It then ask for confirmation to kills one or all the processes listed. 
    Useful when an application is run multiple processes or when you are not sure of the name of the process you want to stop.

PARAMETERS
    -SearchString <String>
        Specifies the string to use for search.

.EXAMPLE
    Stop-SelectProcess chrome

    Name     PID     CPU(mb) Path
    ----     ---     ------- ----
    chrome 17876  0.01128125 C:\Program Files (x86)\Google\Chrome 
    chrome 16520 0.011046875 C:\Program Files (x86)\Google\Chrome
    chrome  2776 0.000171875 C:\Program Files (x86)\Google\Chrome 

    Enter an PID from the list above or 'a' to kill all: 2776
    Done

#>
function Stop-SelectProcess {
    param ([Parameter(Mandatory=$true)][string] $SearchString)
    try {
        $adjPs = Get-Process $SearchString -ErrorAction Stop | Select-Object Name, @{name='PID';expression={$_.id}}, @{name='CPU(mb)';expression={$_.cpu/1000}}, Path | Sort-Object 'CPU(mb)' -Descending
        Out-Host -InputObject $adjPs
        $ans = $(Read-Host "Enter an PID from the list above or 'a' to kill all")
        $count = 0
        if (($ans -ieq "a") -or ($([int]$ans) -in $adjPs.pid)) {
            if($ans -ieq "a"){
                $iDs = $adjPs.pid
                while ($count -lt $iDs.length) {
                    try {
                        Stop-Process $iDs[$count] -ErrorAction Stop
                    }
                    catch [Microsoft.PowerShell.Commands.ProcessCommandException] {
                    }
                    $count++
                }
            }
            else{ 
                Stop-Process $([int]$ans)
            }
            Write-Output "Done"
            Write-Output " "
        }
        else {
            Write-Host -object "Kill process not successful. PId is not amongst those displayed in the list above." -ForegroundColor red
            Write-Output " "
        }

    }
    catch [Microsoft.PowerShell.Commands.ProcessCommandException] {
        Write-error -ErrorRecord $_ 
    }
    catch [System.InvalidCastException] {
        Write-Error -Message "That was not a valid input. Enter an PID from the list above or 'a' to kill all" -Category $_.CategoryInfo.Category -ErrorId "InvalidInput" -CategoryReason $_.CategoryInfo.Reason -CategoryTargetName $_.CategoryInfo.TargetName -CategoryTargetType $_.CategoryInfo.TargetType
    }
   
}

<#
.SYNOPSIS
    Displays a specified number of lines from the beginning of a file.

.DESCRIPTION
    Prints to screen a specified number of lines from the beginning of a file. By default, it prints the first 5 lines of the specified files.

PARAMETERS
    -Path <String>
        The path of the file.
    -Lines <long>
        The number of lines to print. Default is 5 lines

.EXAMPLE
    Head C:\Users\user\Documents\test.txt
    This is a line 1
    This is a line 2
    This is a line 3
    This is a line 4
    This is a line 5

.EXAMPLE
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

#>
function Head {
    param (
        [Parameter(Mandatory=$true, position=0)][string] $Path, [Parameter(position=1)][long] $Lines = 5
    )
    try {
        $text = Get-Content $Path -TotalCount $lines -ErrorAction stop
    }
    catch [System.Management.Automation.ItemNotFoundException] {
        Write-error -ErrorRecord $_
    }
    return $text
    
}

<#
.SYNOPSIS
    Displays a specified number of lines from the beginning of a file.

.DESCRIPTION
    Prints to screen a specified number of lines from the beginning of a file. By default, it prints the first 5 lines of the specified files.

PARAMETERS
    -Path <String>
        The path of the file.
    -Lines <long>
        The number of lines to print. Default is 5 lines

.EXAMPLE
    Tail C:\Users\user\Documents\test.txt
    This is a line 6
    This is a line 7
    This is a line 8
    This is a line 9
    This is a line 10

.EXAMPLE
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

#>
function Tail {
    param (
        [Parameter(Mandatory=$true, position=0)][string] $Path, [Parameter(position=1)][int] $lines = 5
    )
    try {
        $text = Get-Content $Path -Tail $lines -ErrorAction stop
    }
    catch [System.Management.Automation.ItemNotFoundException] {
        Write-error -ErrorRecord $_
    }
    return $text
    
}