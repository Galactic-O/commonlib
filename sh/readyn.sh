# ==============================================================================
# READYN
# ------------------------------------------------------------------------------
# Prompts the user with a yes/no question, with preference for "yes". Preference
# for "no" can be achieved with "readny.sh".
# Returns 0 if the answer is yes and 1 otherwise.
# ------------------------------------------------------------------------------
# ARGS:
# - $1 -> String : Yes/no question
# ==============================================================================

_readyn () {
	# Force an answer from the user
	while :
	do
	local yn;

		# Print the question with format "Question? [Y/n]:"
		printf "%s? [Y/n]: " "$1";
		read yn;

		# Read answers from regex as single char or word in any case combination
		if [[ "$yn" =~ ^([yY][eE][sS]|[yY])?$ ]]; then
			return 0;
			break;
		elif [[ "$yn" =~ ^([nN][oO]|[nN])+$ ]]; then
			return 1;
			break;
		fi
	done
}

# ==============================================================================
# DEMONSTRATION
# ==============================================================================

if _readyn "Do you like this script"; then
	printf "Thanks! I put some effort into it!\n"
else
	printf "Aw man... I'm sorry if I disappointed you :(\n"
fi
