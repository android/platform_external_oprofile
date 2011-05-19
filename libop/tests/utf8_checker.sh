#!/bin/sh

# This script validates that all event descriptions in the various
# architecture-specific events files contain only UTF-8 characters.
# While this is not a requirement for the command-line tools of oprofile,
# many GUI tools (in particular, the oprofile plugin from Eclipse LTP) do
# have such a requirement.

CMD_OUTPUT=$(find ../../events/ -name events -type f | xargs cat  | perl -ne '/^(([\x00-\x7f]|[\xc0-\xdf][\x80-\xbf]|[\xe0-\xef][\x80-\xbf]{2}|[\xf0-\xf7][\x80-\xbf]{3})*)(.*)$/;print "$ARGV:$.:".($-[3]+1).":$_" if length($3)')

if [ -n "$CMD_OUTPUT" ] ; then
	echo "   << UTF-8 validation of events files FAILED >>"
	echo "$CMD_OUTPUT"
	exit 1
fi

