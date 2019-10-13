# ==============================================================================
# TITLEBOX
# ------------------------------------------------------------------------------
# Draws a title box with custom spacing.
# ------------------------------------------------------------------------------
# ARGS:
# - $1 -> String : Title
# - $2 -> int : Top spacing (defaults to 0)
# - $3 -> int : Bottom spacing (defaults to 0)
# - $4 -> int : Left spacing (defaults to 0)
# - $5 -> int : Right spacing (defaults to 0)
# - $6 -> int : Box spacing from left of screen (defaults to 0)
# - $7 -> String : Border type override from default (#)
#         :: dash2fat -> Fat 2-dash lines (╏)
#         :: dash2thin -> Thin 2-dash lines (╎)
#         :: dash3fat -> Fat 3-dash lines (┇)
#         :: dash3thin -> Thin 3-dash lines (┆)
#         :: dash4fat -> Fat 4-dash lines (┋)
#         :: dash4thin -> Thin 4-dashe lines (┊)
#         :: double -> Double box lines (║)
#         :: doublemono -> Double horizontal and mono vertical (thin)
#         :: monodouble -> Mono horizontal and double vertical (thin)
#         :: monofat -> Fat box lines(┃)
#         :: monofatthin -> Fat horizontal and thin vertical
#         :: monothin -> Thin box lines (│)
#         :: monothinfat -> Thin horizontal and fat vertical
# ARGS POLICY:
# - Args can be the title only ($1), title and override ($1 $7) with $7 as $2,
#   title and ALL spacing options ($1 $2 $3 $4 $5 $6) and all args in order.
# - To enter a spacing arg, the rest of them must also be entered in order.
# ==============================================================================

_titlebox () {
	# Args number error checking
	if [ $# -eq 0 ] || [ $# -ge 3 ] && [ $# -le 5 ]; then
		printf "Wrong args for _titlebox. Please refer to the documentation.\n"
		return 1;
	fi
	
	# Variables declaration and initialisation to defaults
	local top=0
	local bottom=0
	local left=0
	local right=0
	local veryleft=0

	# Set default spacing args taking in account boxchars offsets
	if [ $# -ge 6 ]; then
		top=$2
		bottom=$3

		if [ $4 -ne 0 ]; then
			left=`expr $4 + 1`
		fi

		if [ $5 -ne 0 ]; then
			right=`expr $5 + 1`
		fi

		if [ $6 -ne 0 ]; then
			veryleft=`expr $6 + 1`
		fi
	fi

	# Compute the length of the title passed as an argument
	local title_length=${#1}
	
	# Compute the length of the horizontal border based on the title length and
	# horizontal padding options
	local horizontal_length=`expr $title_length + $left + $right`

	# Set default box boders
	# ("horizontal" "vertical" "topleft" "topright" "bottomleft" "bottomright")
	local borders=("#" "#" "#" "#" "#" "#")

	# Check for override arg
	if [ $# -eq 2 ]; then
		local override="$2";
	elif [ $# -eq 7 ]; then
		local override="$7";
	fi

	# Override border type if override has been defined
	if [ "$override" != "" ]; then
		case "$override" in
			"dash2fat")
				borders=("╍" "╏" "┏" "┓" "┗" "┛");;

			"dash2thin")
				borders=("╌" "╎" "┌" "┐" "└" "┘");;

			"dash3fat")
				borders=("┅" "┇" "┏" "┓" "┗" "┛");;

			"dash3thin")
				borders=("┄" "┆" "┌" "┐" "└" "┘");;

			"dash4fat")
				borders=("┉" "┋" "┏" "┓" "┗" "┛");;

			"dash4thin")
				borders=("┈" "┊" "┌" "┐" "└" "┘");;

			"double")
				borders=("═" "║" "╔" "╗" "╚" "╝");;

			"doublemono")
				borders=("═" "│" "╒" "╕" "╘" "╛");;

			"monodouble")
				borders=("─" "║" "╓" "╖" "╙" "╜");;

			"monofat")
				borders=("━" "┃" "┏" "┓" "┗" "┛");;

			"monofatthin")
				borders=("━" "│" "┍" "┑" "┕" "┙");;

			"monothin")
				borders=("─" "│" "┌" "┐" "└" "┘");;
						  
			"monothinfat")
				borders=("─" "┃" "┎" "┒" "┖" "┚");;
 		esac
	fi

	# Draw the top line
	_titlebox_drawboxline $veryleft "${borders[2]}" "${borders[0]}" \
			                $horizontal_length "${borders[3]}" 1

	# Draw the top spacing lines
	_titlebox_drawboxline $veryleft "${borders[1]}" " " \
	                      $horizontal_length "${borders[1]}" $top

	# Draw the title line (see _titlebox_drawboxline)
	for (( i=0; i<$veryleft; i++ )) do
		printf " ";
	done
	
	printf "${borders[1]}"

	for (( i=0; i<$left; i++ )) do
		printf "%s" " ";
	done

	printf "$1"

	for (( i=0; i<$right; i++ )) do
		printf "%s" " ";
	done
	
	printf "%s\n" "${borders[1]}"

	# Draw the top spacing lines
	_titlebox_drawboxline $veryleft "${borders[1]}" " " \
	                      $horizontal_length "${borders[1]}" $bottom

	# Draw the bottom line
	_titlebox_drawboxline $veryleft "${borders[4]}" "${borders[0]}" \
	                      $horizontal_length "${borders[5]}" 1
}


# ==============================================================================
# AUXILIARY FUNCTIONS
# ------------------------------------------------------------------------------
# Used to prevent code repetition.
# ==============================================================================

# Prints $1 spaces, "$2", "$3" $4 times, "$5", and a linefeed $6 times
# These are printed using for loops becuase I've been fighting with awk to no
# avail to printf multibyte characters (awk '{printf "%*s", $1, $2}').
# A pull request fixing this circus of degradation would be nice!
_titlebox_drawboxline() {
	for (( i=0; i<$6; i++ )) do
		for (( j=0; j<$1; j++ )) do
			printf " ";
		done;

		printf "%s" "$2"

		for (( j=0; j<$4; j++ )) do
			printf "%s" "$3";
		done;

		printf "%s\n" "$5";
	done
}


# ==============================================================================
# DEMONSTRATION
# ==============================================================================

_titlebox "$1" $2 $3 $4 $5 $6 $7;
