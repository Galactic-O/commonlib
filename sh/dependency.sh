# ==============================================================================
# DEPENDENCY
# ------------------------------------------------------------------------------
# Queries a package manager (pacman by default) for a package. If it doesn't
# exists, it appends it to a new "~/.scriptdependencies" file. It also install
# said dependencies.
# ------------------------------------------------------------------------------
# ARGS:
# - $1 -> The package manager to be queried.
# - $2 -> The package to be searched for
# ------------------------------------------------------------------------------
# ARGS POLICY:
# - If only $1 is provided, the program searches for "~/.scriptsdependencies"
# and installs all the listed programs.
# ==============================================================================

_dependency () {
	# Args number error checking
	if [ $# -lt 1 ] || [ $# -gt 2 ]; then
		printf "Wrong args for _dependency. Please refer to the documentation.\n"
		return 1;
	fi

	if [ $# -eq 1 ]; then
		# Install packages listed in "~/.scriptdependencies"
		if [ -e ~/.scriptdependencies ]; then
			case $1 in
				"pacman")
					sudo pacman -S - < ~/.scriptdependencies;;
				"yay")
					yay -S - < ~/.scriptdependencies;;
			esac
		else
			printf "The dependencies file could not be found.\n";
	 		return 2;
		fi
	
		rm ~/.scriptdependencies
	else
		case $1 in
			"pacman")
				if ! pacman -Q $2 1> /dev/null 2>&1; then
					echo "$2" >> ~/.scriptdependencies;
				fi;;
			"yay")
				if ! yay -Q $2 1> /dev/null 2>&1; then
					echo "$2" >> ~/.scriptdependencies;
				fi;;
		esac
	fi
}


# ==============================================================================
# DEMONSTRATION
# ==============================================================================

# Neofetch is a harmless enough package to test this
printf "Adding neofetch via pacman...\n"
_dependency pacman neofetch
printf "Calling to install neofetch...\n\n"
_dependency pacman
