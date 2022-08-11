function Get-Current-Git-Branch()
{
	git rev-parse --abbrev-ref HEAD
}

function Get-Main-Git-Branch()
{
	git show-ref -q --verify refs/heads/main

	if ($LastExitCode -eq 0)
	{
		Write-Output 'main'
	}
	else
	{
		Write-Output 'master'
	}
}

function gst
{
	git status @Args
}

function gba
{
	git branch -a
}

function gbl
{
	git branch -l
}

function gpp
{
	git push @Args
}

function gpl
{
	git pull @Args
}

function gfa
{
	git fetch --all --prune @Args
}

function gco
{
	git checkout @Args
}

function gcom
{
	git checkout origin/$(Get-Main-Git-Branch) @Args
}

function gcbb
{
	git checkout -b @Args
}

function gpf
{
	git push --force
}

function gpsup
{
	$currentBranch = Get-Current-Git-Branch
	git push --set-upstream origin $currentBranch
}

function grset
{
	git remote set-url @Args
}

function gpum
{
	git pull upstream $(Get-Main-Git-Branch)
}

function grau
{
	git remote add upstream @Args
}

function grad
{
	git remote add downstream @Args
}

function gcl
{
	git clone @Args
}

function grlm
{
	$currentBranch = Get-Current-Git-Branch
	git rev-list --count $(Get-Main-Git-Branch)..$currentBranch
}

function grlmo
{
	$currentBranch = Get-Current-Git-Branch
	git rev-list --count origin/$(Get-Main-Git-Branch)..$currentBranch
}

function grba
{
	git rebase --abort
}

function grbm
{
	git rebase origin/$(Get-Main-Git-Branch)
}

function grbc
{
	git rebase --continue
}

function gom
{
	git merge origin/$(Get-Main-Git-Branch)
}

function bdr
{
	git br-delete-regex
}

function bdu
{
	git br-delete-useless-force
}

function bduf
{
	git br-delete-useless-force
}

function Clear-Branches
{
	Write-Host 'Fetching and pruning remotes' -ForegroundColor Green

	git fetch --all --prune @Args

	Write-Host 'Pruning local branches' -ForegroundColor Magenta

	foreach ($branch in $(git br-delete-useless-force))
	{
		Write-Host $branch -ForegroundColor Red
	}

	Write-Host '-------------' -ForegroundColor Gray
}
