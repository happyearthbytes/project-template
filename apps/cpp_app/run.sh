#catch2
app -o junit.xml -r junit
gcovr --xml -r src --object-directory=bin -o coverage.xml
cppcheck