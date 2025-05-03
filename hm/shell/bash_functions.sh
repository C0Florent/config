put_nonzero_status()
{
    local __status=$?
    if [ $__status -ne 0 ]; then
        printf '%03hhu' $__status
    fi

    for hook in $PS1_HOOKS; do
	    $hook $__status
    done

    unset __status
}

play_async()
{
	(&>/dev/null gsound-play -f "$1" &)
}

play_PS1_sound()
{
	[ -z $MUTE ] && exit 1

	if [ $1 -eq 0 ]; then
		play_async "$BEEPFILE"
	else
		play_async "$BOOPFILE"
	fi
}

unmute()
{
	MUTE=false
}

mute()
{
	MUTE=
}

cfg() # $1 should be the shell to be launched in /etc/nixos
{
	local prev_OLDPWD="$OLDPWD"

	cd /etc/nixos
	echo "Opening shell \`$1'"
	$1
	cd - >/dev/null

	OLDPWD="$prev_OLDPWD"
}

put_shlvl()
{
	local __status=$?

	if [ $SHLVL -ne 1 ]; then
		echo -n "($SHLVL)"
	fi
	exit $__status

}

cdp()
{
	cd $1
	nix develop
}

cod()
{
	local CODE=codium
	local CODE_CMD="$(which $CODE)"

	if [ -z $CODE_CMD ]; then
		echo >&2 "Couldn't find $CODE in PATH"
		return 1
	fi

	if [ ! -z "$1" ]; then
		cd "$1" || return 1
	fi

	if [ -r "./flake.nix" ]; then
		echo "$FUNCNAME: Launching $CODE in nix dev shell"
		nix develop -c "$CODE_CMD" . || return $?
	else
		echo "$FUNCNAME: Launching $CODE"
		"$CODE_CMD" . || return $?
	fi

	if [ -z "$TIMEOUT_CLOSE" ]; then
		local TIMEOUT_CLOSE=0
	fi

	echo
	echo "$FUNCNAME: Success, exiting in $TIMEOUT_CLOSE second(s)..."
	sleep "$TIMEOUT_CLOSE"
	exit
}
