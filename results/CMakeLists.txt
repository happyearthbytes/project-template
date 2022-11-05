# This common include file performs the majority of the CMake setup options
include(cmake/cmake_common/cmake_include.cmake)

# cmake_minimum_required is required in the top level CMakeLists.txt
cmake_minimum_required(VERSION ${CMAKE_MINIMUM_REQURED})

# project is required in the top level CMakeLists.txt
# Set the initial project name
# This will be overridden in sub projects.
# TODO note that adding VERSION and DESCRIPTION causes issues
project( ${TOPLEVEL_PROJECT_NAME} )

# CTest must be called after project
include(CTest)

# Project specific cmake commands
include_print(cmake/project.cmake)

###############################################################################
# DEFINE INCLUDES
###############################################################################
include(CPack)

# Project specific cmake commands to run in post
include_print(cmake/project_post.cmake)
