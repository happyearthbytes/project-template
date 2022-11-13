URL=https://leetcode.com/discuss/general-discussion/460599/blind-75-leetcode-questions

# "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless --dump-dom ${URL} > out.html
cat out.html  | sed 's/>/>\n/g' | grep leetcode | grep problems | sed 's|.*\(https.*\)/">|\1|' > links.txt

while read p; do
  NAME=$(echo "$p" | sed 's|.*/||')
  echo "$NAME"
  DIRNAME=problems/"$NAME"
  mkdir -p "${DIRNAME}"
  touch "${DIRNAME}"/"${NAME}".orig.cpp
  rm "${DIRNAME}"/"${NAME}".cpp
  touch "${DIRNAME}"/"${NAME}".mine.cpp
  touch "${DIRNAME}"/"${NAME}".html
  touch "${DIRNAME}"/"${NAME}".instructions.txt
  touch "${DIRNAME}"/"${NAME}".code.txt
  # "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless --dump-dom "${p}" > "${DIRNAME}"/"${NAME}".html
  cat "${DIRNAME}"/"${NAME}".html | sed -n '\, question-content, s| question-content_.*"><div><p>|\n\n---\n\n|p' | tail -1 > "${DIRNAME}"/"${NAME}".instructions.txt
  cat "${DIRNAME}"/"${NAME}".instructions.txt | sed 's|^|// |' > "${DIRNAME}"/"${NAME}".orig.cpp
  cat "${DIRNAME}"/"${NAME}".html | sed 's/>/>\n/g' | grep " CodeMirror-line " -A20 | sed -n '\,^[^<], p' | egrep -v "^--$" | sed -E 's|<(/)?span.*||' | sed 's|.*</div>|<newline>\n|' | sed 's|&nbsp;| |g' | tr -d '\n' | sed 's/<newline>/\n/g' > "${DIRNAME}"/"${NAME}".code.txt
  cat "${DIRNAME}"/"${NAME}".code.txt >> "${DIRNAME}"/"${NAME}".orig.cpp
  echo "" >> "${DIRNAME}"/"${NAME}".orig.cpp
  # Add contents if .cpp is empty
  [ -s "${DIRNAME}"/"${NAME}".mine.cpp ] || cp "${DIRNAME}"/"${NAME}".orig.cpp "${DIRNAME}"/"${NAME}".mine.cpp
done < links.txt
