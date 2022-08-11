function yc
{
	rmfe $(yarn cache dir)
	rmfe "node_modules"
	rmfe "dist"
}

function yr
{
	yc
	yarn
}

function yi
{
	$YarnVersion = $(yarn --version)

	if ($YarnVersion.StartsWith('1'))
	{
		yarn --frozen-lockfile @Args
	}
	else
	{
		yarn --immutable @Args
	}
}

function yui
{
	$YarnVersion = $(yarn --version)

	if ($YarnVersion.StartsWith('1'))
	{
		yarn upgrade-interactive --latest
	}
	else
	{
		yarn upgrade-interactive
	}
}

function ylx
{
	yarn dlx @Args
}
