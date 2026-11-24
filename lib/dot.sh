#!/bin/sh
# Dotfile helper operations, invoked as: sh lib/dot.sh <op> args...
#
# Set DRY_RUN=1 to print actions instead of performing them.

set -eu

usage() {
	cat >&2 <<EOF
Usage: $0 <op> args...

Ops:
  link    <src> <dest>          symlink dest -> abs(src), backing up dest to dest~
  install <src> <dest> [mode]   copy src to dest with parent dirs, backing up dest
  append  <file> <line>         append line to file unless already present
  fetch   <url> <dest>          download url to dest, creating parent dirs
  prune   <repo> <dir[:depth]>...
                                remove broken symlinks under dirs pointing into repo

Environment:
  DRY_RUN=1                     print actions without performing them
EOF
	exit 2
}

# Print an action; return non-zero (skip it) under DRY_RUN.
act() {
	if [ -n "${DRY_RUN:-}" ]; then
		echo "would: $*"
		return 1
	fi
	return 0
}

strip_slash() {
	s=$1
	while [ "${#s}" -gt 1 ] && [ "${s%/}" != "$s" ]; do
		s=${s%/}
	done
	printf '%s\n' "$s"
}

# Symlink <dest> -> absolute path of <src>, backing up a non-link dest to dest~.
dot_link() {
	[ $# -eq 2 ] || usage
	src=$(strip_slash "$1")
	dest=$(strip_slash "$2")
	if [ ! -e "$src" ]; then
		echo "link: source does not exist: $src" >&2
		exit 1
	fi
	abs=$(readlink -f "$src")
	if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$abs" ]; then
		return 0
	fi
	if [ -e "$dest" ] && [ ! -L "$dest" ]; then
		if act "backup '$dest' -> '$dest~'"; then
			mv -fT "$dest" "$dest~"
			echo "backup '$dest' -> '$dest~'"
		fi
	fi
	if act "link '$dest' -> '$abs'"; then
		mkdir -p "$(dirname "$dest")"
		ln -sfnT "$abs" "$dest"
		echo "link '$dest' -> '$abs'"
	fi
}

# Copy <src> to <dest>, backing up dest to dest~; apply [mode] or keep src mode.
dot_install() {
	case $# in 2 | 3) ;; *) usage ;; esac
	src=$1
	dest=$2
	mode=${3:-}
	if [ ! -f "$src" ]; then
		echo "install: source does not exist: $src" >&2
		exit 1
	fi
	if [ -f "$dest" ] && cmp -s "$src" "$dest"; then
		return 0
	fi
	if act "install '$src' -> '$dest'${mode:+ (mode $mode)}"; then
		mkdir -p "$(dirname "$dest")"
		cp -T --backup=simple --suffix='~' --preserve=mode "$src" "$dest"
		[ -z "$mode" ] || chmod "$mode" "$dest"
		echo "install '$src' -> '$dest'${mode:+ (mode $mode)}"
	fi
}

# Append <line> to <file> unless an exact full-line match exists.
dot_append() {
	[ $# -eq 2 ] || usage
	file=$1
	line=$2
	if [ -f "$file" ] && grep -Fqx -- "$line" "$file"; then
		return 0
	fi
	if act "append '$line' >> '$file'"; then
		mkdir -p "$(dirname "$file")"
		printf '%s\n' "$line" >>"$file"
		echo "append '$line' >> '$file'"
	fi
}

# Download <url> to <dest> via a temp file in the same dir.
dot_fetch() {
	[ $# -eq 2 ] || usage
	url=$1
	dest=$2
	act "fetch '$url' -> '$dest'" || return 0
	dir=$(dirname "$dest")
	mkdir -p "$dir"
	tmp=$(mktemp "$dir/.dot-fetch.XXXXXX")
	trap 'rm -f "$tmp"' EXIT INT TERM
	curl -fL -o "$tmp" "$url"
	mv -fT "$tmp" "$dest"
	trap - EXIT INT TERM
	echo "fetch '$url' -> '$dest'"
}

# Remove broken symlinks under each <dir[:depth]> whose target lies inside <repo>.
dot_prune() {
	[ $# -ge 2 ] || usage
	repo=$(readlink -f "$(strip_slash "$1")")
	shift
	for arg in "$@"; do
		dir=$arg
		depth=
		case $arg in
		*:*)
			d=${arg##*:}
			case $d in
			'' | *[!0-9]*) ;;
			*)
				dir=${arg%:*}
				depth=$d
				;;
			esac
			;;
		esac
		[ -d "$dir" ] || continue
		find "$dir" ${depth:+-maxdepth "$depth"} -xtype l -print |
			while IFS= read -r l; do
				t=$(readlink "$l")
				case $t in
				"$repo" | "$repo"/*)
					if act "remove '$l' -> '$t'"; then
						rm -f "$l"
						echo "remove '$l' -> '$t'"
					fi
					;;
				esac
			done
	done
}

[ $# -ge 1 ] || usage
op=$1
shift

case $op in
link) dot_link "$@" ;;
install) dot_install "$@" ;;
append) dot_append "$@" ;;
fetch) dot_fetch "$@" ;;
prune) dot_prune "$@" ;;
*) usage ;;
esac
