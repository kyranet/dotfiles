# ----------------------- #
# Filesystem (Navigation) #
# ----------------------- #
function ..
{
	Set-Location ../
}

function ...
{
	Set-Location ../../
}

function ....
{
	Set-Location ../../../
}

function .....
{
	Set-Location ../../../../
}

# ------------------ #
# Filesystem (Write) #
# ------------------ #
function Remove-Files-Recursively-Forced([Parameter(ValueFromRemainingArguments = $True)] [String[]]$Paths)
{
	foreach ($path in $Paths)
	{
		Remove-Item -Recurse -Force -Path $path
	}
}

function Remove-Files-Recursively-Forced-Ensure([Parameter(ValueFromRemainingArguments = $True)] [String[]]$Paths)
{
	foreach ($path in $Paths)
	{
		if (Test-Path -Path $path)
		{
			Remove-Item -Recurse -Force -Path $path
		}
	}
}

function Open-New-Directory([String]$Path)
{
	mkdir $Path > $null
	Set-Location $Path
}

# ------------- #
# Miscellaneous #
# ------------- #
function Update-Env
{
	$env:Path = [System.Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path', 'User')
}

function Get-ChildItem-Detailed
{
	Get-ChildItem -Attributes ReadOnly, Hidden, System, Directory, Archive, Device, Normal, Temporary, SparseFile, ReparsePoint, Compressed, Offline, NotContentIndexed, Encrypted, IntegrityStream, NoScrubData @Args | Format-Wide -Column 3
}

function Open-Tunnel
{
	cloudflared tunnel run @Args
}

function Get-Weather([string] $City)
{
	curl "wttr.in/~$([System.Web.HTTPUtility]::UrlPathEncode($City))?format=v2"
}
