CHECKSTYLE="checkstyle"
CHECKS_XML="google_checks.xml"
java -jar ${CHECKSTYLE} -c ${CHECKS_XML} -f xml -o=checkstyle.xml src
