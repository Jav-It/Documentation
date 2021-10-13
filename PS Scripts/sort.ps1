# Sort #
# Sorts videos into folder structure <Series>/<Perfomer>/<Video>
# Assumes folders have been renamed using rename.ps1 script to <Content ID> - <Studio> - <Performer> format.

# Usage:
# Copy this script into directory and run (Right-Click > Run With Powershell)
# OR
# Open Powershell and execute with usage: .\sort.ps1 -dir <directory>

param (
    [string]$dir,
    [switch]$test = $false
)

# Default to current directory
if ( !(("$dir").Trim()) ) {
    $dir = (Get-Item .).FullName
}

ls -Directory $dir | Where-Object { $_.Name -match "\d*([A-Z,a-z]+)[-]*\d* - .* - (.*)" } | ForEach-Object -Process { 
    $studio = $matches[1]
    $performer = $matches[2]

    if ($matches[2] -like "*,*" -and -not ($matches[2] -like "*(*,*)*")) {
        $performer = "Various"
    }

    $destDir = "$($studio)\$($performer)"
    $fullDir = "$dir\$destDir"

    Write-Host "$($_.Name) `t`t`t $($fullDir)"
    
    if (-not $test) {
        if (-not (Test-Path -Path $fullDir)) { mkdir $fullDir | Out-Null }
        Move-Item -Path $_.FullName -Destination "$fullDir"
    }
}
