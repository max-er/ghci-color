#!/bin/sh

# Color reset
rst=`echo "[0;48;05;16m"`

# Colors
light_blue="[38;05;123m"
error_red="[38;05;202m"
success_green="[38;05;82m"
yellow="[38;05;228m"
red="[38;05;210m"
orange="[38;05;223m"
cyan="[38;05;51m"
green="[38;05;46m"
purple="[38;05;201m"
grey="[38;05;240m"



# Patterns

lexemize=':loop s/^(("((\\.)|[^\\"])*"|\n[[:alpha:]]+[[:alnum:].]*\n|\n[[:digit:]]+([.][[:digit:]]+)?\n|\n[=*}{()[]\n|\n[]]\n|[, ]|\n['"'][[:alnum:]]['"']\n|\n::\n|\n->\n|\n=>\n)*)([[:alpha:]]+[[:alnum:].]*|[[:digit:]]+([.][[:digit:]]+)?|['"'][[:alnum:]]['"']|=>|[=*}{()[]|[]]|::|->)/\1\n\6\n/; t loop;'

cOrange="s/\n([[:alpha:]]+[[:alnum:].]*|[*=])\n/$orange\1$rst/g;"
cGreen="s/\n(['][[:alnum:]][']|[)(])\n/$green\1$rst/g;"
cRed="s/\n([[:digit:]]+([.][[:digit:]]+)?)\n/$red\1$rst/g;"
cCyan="s/\n([[]|[]]|::|->|=>)\n/$cyan\1$rst/g;"
cPurple="s/\n([}{])\n/$purple\1$rst/g;"
cStrings='s/"((\\.)|[^\\"])*"/'"$yellow&$rst/g;"

loading="/^Loading package /{s/^.*$/$grey&$rst/;}"
failed_loading="/^Failed, modules loaded: none.$/{s/^.*$/$error_red&$rst/;}"
success_loading="/^Ok, modules loaded:/{s/^.*$/$success_green&$rst/;}"
interactive="/^<interactive>:/{s/^.*$/$error_red&$rst/;}"

exec "`which ghc`" --interactive ${1+"$@"} 2>&1 |\
sed -r "
$success_loading
$failed_loading
$loading
$interactive
$lexemize $cOrange $cRed $cGreen $cCyan $cPurple $cStrings"
