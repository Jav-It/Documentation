# Rename #
# Strips title from directory name and leaves in <Content ID> - <Studio> - <Performer>.

# Usage:
# Copy this script into directory and run (Right-Click > Run With Powershell)
# OR
# Open Powershell and execute with usage: .\simplify-name.ps1 -dir <directory>

param (
    [string]$dir
)

# Default to current directory
if ( !(("$dir").Trim()) ) {
    $dir = (Get-Item .).FullName
}

ls -Directory $dir | Rename-Item -NewName { $_.Name -replace '.*\((.* - .*)\)$', '$1' }
