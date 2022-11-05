###############################################################################
# ONLY RUN ONCE
###############################################################################
if(NOT DEFINED CMAKE_COMMON_INCLUDES)
  set(CMAKE_COMMON_INCLUDES 1)
else()
  return()
endif()

###############################################################################
# SET MODULE PATH
###############################################################################
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/cmake_common/" ${CMAKE_MODULE_PATH})

project(initial)

###############################################################################
# INCLUDES
###############################################################################

include(cmake_functions)

###############################################################################
# SIMPLE VARIABLES
###############################################################################

# cmake minimum version
set(CMAKE_MINIMUM_REQURED "2.8.9")

# Used to generate inputs for cppcheck etc..
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Enable clang tidy. Disable this if clang-tidy is not installed
# TODO only available in cmake 3.7.2+
# set(CMAKE_CXX_CLANG_TIDY clang-tidy -checks=-*,readability-*)

###############################################################################
# FILE VARIABLES
###############################################################################
# Read top level project variables.
# This is useful if submodules wish to inherit top level properties

get_variable(TOPLEVEL_PROJECT_NAME "PROJECT_NAME")
get_variable(TOPLEVEL_SUMMARY "SUMMARY")
get_variable(TOPLEVEL_PACKAGE_CONTACT "PACKAGE_CONTACT")
get_variable(TOPLEVEL_PACKAGE_VENDOR "PACKAGE_VENDOR")
get_variable(TOPLEVEL_HOMEPAGE_URL "HOMEPAGE_URL")
get_variable(TOPLEVEL_LICENSE_FILE "LICENSE_FILE")
get_variable(TOPLEVEL_README_FILE "README_FILE")
get_variable(TOPLEVEL_CHANGELOG_FILE "CHANGELOG_FILE")
get_variable(ENVIRONMENT_FILE "ENVIRONMENT_FILE")

# Read from FILE
get_variable_file(TOPLEVEL_VERSION "VERSION_FILE")
get_variable_file(TOPLEVEL_LICENSE "LICENSE_FILE")
get_variable_file(TOPLEVEL_README "README_FILE")

# Read environment vars from FILE
read_env("${ENVIRONMENT_FILE}")

###############################################################################
# OTHER VARIABLES
###############################################################################

# Get the major version of the operating system
execute_process( OUTPUT_VARIABLE OS_VER
  COMMAND /usr/bin/lsb_release -rs
  COMMAND /usr/bin/awk -F. "{print $1}"
)
string( STRIP "${OS_VER}" OS_VER )

# Get the current time
string( TIMESTAMP TIMESTAMP "%Y%m%d%H%M" )
string( SUBSTRING "${TIMESTAMP}" 0 4 cur_year )

# Set the OS architecture
set( OS_ARCH   "el${OS_VER}.${CMAKE_HOST_SYSTEM_PROCESSOR}" )

# Define the location where installations will be made
set( CMAKE_INSTALL_PREFIX "/opt/${TOPLEVEL_PROJECT_NAME}" CACHE STRING "The install prefix" )

if (NOT CMAKE_BUILD_TYPE)
  set( CMAKE_BUILD_TYPE "Release" )
endif()

###############################################################################
# CPACK
###############################################################################

include(cmake_cpack_common)

###############################################################################
# CONFIGURATIONS
###############################################################################

# Set up for ctest
enable_testing()

###############################################################################
# LOGGING
###############################################################################

message( "*****************************************************************************" )
message( "* Project:             ${TOPLEVEL_PROJECT_NAME}" )
#message( "* Summary:             ${TOPLEVEL_SUMMARY}" )
message( "* Targets:             ${TARGETS}" )
# message( "* Source Directory:    ${CMAKE_SOURCE_DIR}" )
# message( "* Binary Directory:    ${CMAKE_BINARY_DIR}" )
# message( "* Install Prefix:      ${CMAKE_INSTALL_PREFIX}" )
# if ( CMAKE_BUILD_TYPE )
#   message( "* Build Type:          ${CMAKE_BUILD_TYPE}" )
# endif()
# message( "* Compiler:            ${CMAKE_CXX_COMPILER} ${CMAKE_CXX_COMPILER_VERSION}" )
message( "*****************************************************************************" )

###############################################################################
# Includes
###############################################################################

# None at this time