function Start-MSBuild-Run
{
	param (
		[string] $MsBuild,
		[string] $Path,
		[string] $Type = "build",
		[string] $Configuration = "Debug",
		[string] $Platform = "x64",
		[string] $WarningLevel = "0",
		[string] $Verbosity = "minimal"
	)

	# Run the process
	$private:startTime = Get-Date
	& msbuild @("-t:$Type", "-p:Configuration=$Configuration;Platform=$Platform;WarningLevel=$WarningLevel", "-verbosity:$Verbosity", "-m", "-noLogo")
	$private:exitTime = Get-Date

	# Print information to the screen
	$private:duration = $exitTime - $startTime
	If ($LastExitCode -Eq 0)
	{
		Write-Host "# Finished building. Took: " -ForegroundColor Green -NoNewLine
		Write-Host ("{0:g}" -f $duration)        -ForegroundColor Cyan  -NoNewLine
		Write-Host "."                           -ForegroundColor Green
	}
	Else
	{
		Write-Host "# Errored when building with code $LastExitCode Took: " -ForegroundColor Red  -NoNewLine
		Write-Host ("{0:g}" -f $duration)                                   -ForegroundColor Cyan -NoNewLine
		Write-Host "."                                                      -ForegroundColor Red
	}
}
