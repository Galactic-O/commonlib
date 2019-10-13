# ==============================================================================
# ERROR
# ------------------------------------------------------------------------------
# Manages error raising and exits program with a custom exit status if the line
# before calling this function returns a non-zero exit status.
# ------------------------------------------------------------------------------
# ARGS:
# - $1 -> Error message to print to stdout
# - $2 -> Exit status to close the program with
# ==============================================================================

_error() {
	# Catch last command's exit status
	local lastcommand=$(echo $?)

	# If last command failed, print an error message in red (typically 1;31) and
	# exit the whole parent program with a custom exit status
	if [ $lastcommand -ne 0 ]; then
		printf "\033[1;31m%s\n" "$1";
		exit $2;
	fi
}


# ==============================================================================
# DEMONSTRATION
# ==============================================================================

ls
_error "This won't print" 1337

ls .theresnofilewiththisname # Please don't create it!
_error "File could not be found. Terminating program!" 2
