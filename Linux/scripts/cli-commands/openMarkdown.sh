#!/bin/sh

# markdown-to-html Required
if ! command -v markdown; then
  echo "markdown-to-html is required to run this script. Install: 'npm i markdown-to-html -g'"
  exit 1
fi

# Temporary Variable(s) Used
OUT_HTML="$(mktemp -u).html"
INPUT=$1

# Verify Arg
if [ "$1" == "" ]; then
  echo "Please enter Markdown file to open"
  exit 1
fi

# Add CSS & div container
echo \
"<style>" \
"  * {" \
"    font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", \"Helvetica Neue\", Helvetica, Roboto, Arial, sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", "Segoe UI Symbol";" \
"    color: #3D3D3D;" \
"  }" \
"  h1, h2, h3, h4, h5, h6 {" \
"    margin: 8px 0px;" \
"  }" \
"  a {" \
"    color: #3F63A6;" \
"  }" \
"  hr {" \
"    opacity: 0.2;" \
"  }" \
"  #main {" \
"    padding: 30px 20vw;" \
"  }" \
"</style>" \
"<div id=\"main\">" > $OUT_HTML

# Convert File to HTML
markdown $INPUT --flavor github-markdown >> $OUT_HTML
echo "</div>" >> $OUT_HTML

# Open file using default Browser
gtk-launch "$(xdg-settings get default-web-browser)" $OUT_HTML

# Remove Temporary File
sleep 1 && rm $OUT_HTML
