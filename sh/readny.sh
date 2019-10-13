# ==============================================================================
# READNY
# ------------------------------------------------------------------------------
# Prompts the user with a yes/no question, with preference for "no". Preference
# for "yes" can be achieved with "readyn.sh".
# Returns 0 if the answer is "no" and 1 otherwise.
# ------------------------------------------------------------------------------
# ARGS:
# - $1 -> String : Yes/no question
# ==============================================================================

_readny () {
	# Force an answer from the user
	while :
	do
	local ny;

		# Print the question with format "Question? [y/N]:"
		printf "%s? [y/N]: " "$1";
		read ny;

		# Read answers from regex as single char or word in any case combination
		if [[ "$ny" =~ ^([nN][oO]|[nN])?$ ]]; then
			return 0;
			break;
		elif [[ "$ny" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
			return 1;
			break;
		fi
	done
}


# ==============================================================================
# DEMONSTRATION
# ==============================================================================

if _readny "Do you like this script"; then
	printf "Aw man... I'm sorry if I disappointed you :(\n"
else
	printf "Thanks! I put some effort into it!\n"
fi
