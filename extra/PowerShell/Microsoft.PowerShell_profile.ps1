$functionsDirectory = "$PSScriptRoot\functions";
$completionsDirectory = "$PSScriptRoot\completions";
$aliasesDirectory = "$PSScriptRoot\aliases";

Import-Module -Name Terminal-Icons
Import-Module -Name PSReadLine

$PSReadLineOptions = @{
	PredictionSource = 'History'
	Colors           = @{
		'Command' = '#8181f7'
		'Comment' = 'DarkGray'
	}
}

Set-PSReadLineOption @PSReadLineOptions
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Load all custom functions
. $functionsDirectory\Git-Functions.ps1
. $functionsDirectory\MSBuild-Functions.ps1
. $functionsDirectory\NodeJS-Functions.ps1
. $functionsDirectory\Terminal-Functions.ps1

# Load all custom completions
& "$completionsDirectory\Volta-Completions.ps1"

# Load all custom aliases
. $aliasesDirectory\Custom-Aliases.ps1

Invoke-Expression (&starship init powershell)
