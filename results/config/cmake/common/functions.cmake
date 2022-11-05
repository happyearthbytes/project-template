###############################################################################
# FUNCTIONS
###############################################################################

#----------------------------------------------------------------------------
# sets the out_var to the var_key value in the configuration file
# e.g. get_variable(MY_VAR "MY_VAR")
# This requires a configuration.yaml file exist at the same level as
# the CMakeList
#----------------------------------------------------------------------------
function(get_variable out_var var_key)
  file(READ "configuration.yaml" CONFIGURATION)
  string(REGEX MATCH "${var_key}: ([^\n]*)" _ ${CONFIGURATION})
  set(out_val ${CMAKE_MATCH_1})
  set(${out_var} ${out_val} PARENT_SCOPE)
  message(DEBUG "${out_var} : ${out_val}")
endfunction()

#----------------------------------------------------------------------------
# separate_arguments will allow strings with spaces to become a list
#----------------------------------------------------------------------------
function(get_variable_list out_var var_key)
  file(READ "configuration.yaml" CONFIGURATION)
  string(REGEX MATCH "${var_key}: ([^\n]*)" _ ${CONFIGURATION})
  set(out_val ${CMAKE_MATCH_1})
  separate_arguments(out_val)
  set(${out_var} ${out_val} PARENT_SCOPE)
  foreach(OUTVAL ${out_val})
    message(DEBUG "${out_var} : ${OUTVAL}")
  endforeach()
endfunction()

#----------------------------------------------------------------------------
# This is similar to get_variable, but will return file contents
#----------------------------------------------------------------------------
function(get_variable_file out_var var_key)
  get_variable(READ_FILE ${var_key})
  file(READ ${READ_FILE} out_read)
  set(${out_var} ${out_read} PARENT_SCOPE)
  message(DEBUG "${out_var} :: ${var_key}")
endfunction()

# Initialize the levels
set(LEVELS "=")

#----------------------------------------------------------------------------
# a wrapper around add_subdirectory.
# Adds some pretty print operations
#----------------------------------------------------------------------------
function(add_subdirectory_print subdirectory)
  set(LOCAL_LEVELS ${LEVELS})
  list(APPEND LOCAL_LEVELS "=")
  list(APPEND LOCAL_LEVELS "=")
  set(LEVELS ${LOCAL_LEVELS})
  string(REPLACE ";" "" PRINT_LEVELS ${LEVELS})
  message(DEBUG "${PRINT_LEVELS}>[${subdirectory}]")
  add_subdirectory(${subdirectory})
  message(DEBUG "<${PRINT_LEVELS}[${subdirectory}]")
  list(REMOVE_AT LOCAL_LEVELS 0)
  list(REMOVE_AT LOCAL_LEVELS 0)
  set(LEVELS ${LOCAL_LEVELS} PARENT_SCOPE)
endfunction()

#----------------------------------------------------------------------------
# A wrapper around includes
# IMPORTANT: This will stop the include from updating the local namespace
#----------------------------------------------------------------------------
function(include_print included)
  string(REPLACE ";" "" PRINT_LEVELS ${LEVELS})
  message(DEBUG ">=${PRINT_LEVELS}>[${included}]")
  include(${included})
  message(DEBUG "<${PRINT_LEVELS}=<[${included}]")
endfunction()


#----------------------------------------------------------------------------
# Read env file and import into environment variables
#
# Read a file and popultate the environment based on key:value pairs
# within the file.
#   example:
#      MY_ENV_VAR_1: /my/value/
#      MY_ENV_VAR_2: another_value
#
#----------------------------------------------------------------------------
function(expand outvar invar)
  string(REGEX MATCH "\\\${[^}]*}" match "${invar}")
  while(match)
    string(REGEX REPLACE "\\\${(.*)}" "\\1" val "${match}")
    string(REPLACE "\${${val}}" "${${val}}" invar "${invar}")
    string(REGEX MATCH "\\\${[^}]*}" match "${invar}")
  endwhile()
  set("${outvar}" "${invar}" PARENT_SCOPE)
endfunction()

#----------------------------------------------------------------------------
# Read env file and import into environment variables
#
# Read a file and popultate the environment based on key:value pairs
# within the file.
#   example:
#      MY_ENV_VAR_1: /my/value/
#      MY_ENV_VAR_2: another_value
#
#----------------------------------------------------------------------------
function(read_env in_file)
  # Read a list of key:value pairs
  file(READ ${in_file} out_read)
  # Separate each line
  string(REPLACE "\n" ";" read_list ${out_read})
  foreach(OUTVAL ${read_list})
    # Extract the key and value pairs
    string(REGEX MATCH "(.*): ([^\n]*)" _ ${OUTVAL})
    set(out_key ${CMAKE_MATCH_1})
    set(out_val ${CMAKE_MATCH_2})
    expand(out_val ${out_val})
    # Set the environment based on the key: value pair
    set(ENV{${out_key}} ${out_val})
    message(DEBUG "ENV: ${out_key}=${out_val}")
  endforeach()
endfunction()

# ---------------------------------------------------------------------------
# Generates a target name.
#
# target_name( <name> [<algorithm>] )
#
# The optional parameter <algorithm> can be one of the following:
#
#   PATH
#     (default) The target name is generated from the current path, relative
#     to the top-level CMake directory, where path separators are replaced by
#     a hyphen.
#
#   PROJECT
#     The target name is generated from the current project name and current
#     directory in the form <project name>-<directory>.
#
#
# Parameters:
#   [OUT] name  The variable in which to store the generated target name
#----------------------------------------------------------------------------
function( target_name name )
  # Set the default algorithm
  set( algorithm "PATH" )
  # Check if algorithm was specified
  if( ${ARGC} GREATER 1 )
    set( algorithm "${ARGV1}" )
  endif()
  # Determine base name
  if( "${algorithm}" STREQUAL "PATH" )
    # ...from the current pathname
    file( RELATIVE_PATH
          relative_path ${CMAKE_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR} )
    string( REPLACE "/" "-" base_name "${relative_path}" )
  elseif( "${algorithm}" STREQUAL "PROJECT" )
    # ...from the current project and local directory name
    get_filename_component( dirname "${CMAKE_CURRENT_SOURCE_DIR}" NAME )
    set( base_name "${CMAKE_PROJECT_NAME}-${dirname}"  )
  else()
    # Unsupported algorithm for building a name
    message( FATAL_ERROR
             "Unsupported algorithm ${algorithm} for generating a name." )
  endif()
  # Return the name
  set( ${name} "${base_name}" PARENT_SCOPE )
endfunction()

# ---------------------------------------------------------------------------
# Sets the project name to the current directory name.
#----------------------------------------------------------------------------
macro( project_from_directory )
  get_filename_component( PROJECT_NAME "${CMAKE_CURRENT_SOURCE_DIR}" NAME )
  project( "${PROJECT_NAME}" )
  message( STATUS "NEW PROJECT: ${PROJECT_NAME}")
endmacro()  # project_from_directory()

# ---------------------------------------------------------------------------
# Finds a program and logs an error if it's not found
# Parameters:
#   [OUT] out_var - The variable that gets written with the path
#   [IN] exe_name - The name of the exe to look for
#   [IN] env_paths - The env variable that describes the path
#----------------------------------------------------------------------------
macro( find_log out_var exe_name env_paths )
  find_program(
      ${out_var} ${exe_name} PATHS ENV ${env_paths}
      DOC "The ${exe_name} program"
  )
  if(NOT ${out_var})
      message(WARNING "Cannot find the ${exe_name} program at ${env_paths}!")
  endif()
endmacro()

# ---------------------------------------------------------------------------
# Creates an installer script
# Installable software can be found with ./scripts/install_software.py
# based on configuration.yaml:
#   INSTALL_FILE: relative to CMakeLists
#   INSTALL_ARG: Command line arguments to install file. Can be blank
#   UNINSTALL_FILE: relative to CMakeLists. Can be the same as the install file
#   UNINSTALL_ARG: Command line arguments to uninstall file. Can be blank
#   THIS_TARGET: The name of the target to install
#   VERSION: The version of the target to install
#----------------------------------------------------------------------------
macro( create_installer )
  get_variable(INSTALL_FILE "INSTALL_FILE") # Used in configure
  get_variable(INSTALL_ARG "INSTALL_ARG")  # Used in configure
  get_variable(UNINSTALL_FILE "UNINSTALL_FILE")  # Used in configure
  get_variable(UNINSTALL_ARG "UNINSTALL_ARG")  # Used in configure
  set(INSTALL_SOFTWARE_IN "${CMAKE_SOURCE_DIR}/scripts/install.py.in")
  set(INSTALL_SOFTWARE    "${CMAKE_CURRENT_BINARY_DIR}/install.py")
  set(INSTALL_FILE_IN     "${CMAKE_CURRENT_SOURCE_DIR}/${INSTALL_FILE}")
  set(INSTALL_FILE_OUT    "${CMAKE_CURRENT_BINARY_DIR}/${INSTALL_FILE}")
  configure_file(${INSTALL_SOFTWARE_IN} ${INSTALL_SOFTWARE})
  configure_file(${INSTALL_FILE_IN} ${INSTALL_FILE_OUT} COPYONLY)
endmacro()  # create_installer()


##############################################################################
# DOCKER
##############################################################################

#----------------------------------------------------------------------------
# Make docker targets
# Parameters:
#   [IN] IMAGE_NAME the name of the image
#   [IN] ARGV1 (1 or 0) 1 = interactive. default = non-interactive
#   [IN] ARGV2 "str" = CTR_NAME for interactive run
#   [IN] ARGV3 "str" = EXEC_CMD for interactive run
#----------------------------------------------------------------------------
macro(make_targets_docker this_target_param)

  # Set the interactive argument
  set( interactive 0 )
  if( ${ARGC} GREATER 1 )
    if( ${ARGV1} )
      set( interactive 1 )
    endif()
  endif()

  # Set the container name argument
  if( ${ARGC} GREATER 2 )
    set( CTR_NAME ${ARGV2} )
  else()
    set( CTR_NAME "" )
  endif()
  # Set the container name argument
  if( ${ARGC} GREATER 3 )
    set( EXEC_CMD ${ARGV3} )
  else()
    set( EXEC_CMD "" )
  endif()

  docker_configure(${this_target_param})
  docker_build()
  docker_start(${interactive})
  docker_stop()
  docker_install()
endmacro()

#----------------------------------------------------------------------------
# Perform a docker build
# Parameters:
#   [IN] IMAGE_NAME the name of the image
#----------------------------------------------------------------------------
macro(docker_configure image_name_param)
  find_log(DOCKER_COMPOSE docker-compose PATH_DOCKER_COMPOSE)
  find_log(DOCKER docker PATH_DOCKER)

  # Update the .env file based on the environment.yaml file
  configure_file(${CMAKE_SOURCE_DIR}/environment/general.env.in ${CMAKE_CURRENT_BINARY_DIR}/.env)

  target_name(THIS_TARGET)
  set(IMAGE_NAME ${image_name_param})
endmacro()

#----------------------------------------------------------------------------
# Perform a docker build
#----------------------------------------------------------------------------
macro(docker_build)
    # Add this to the build group
    add_dependencies(build_group ${THIS_TARGET})
    add_custom_target(${THIS_TARGET} DEPENDS ${THIS_TARGET}.build
        COMMENT "Building ${THIS_TARGET}"
    )
    # Only rebuild when sources modified
    add_custom_command(
        OUTPUT ${THIS_TARGET}.build
        COMMAND ${DOCKER_COMPOSE} -f ${CMAKE_CURRENT_SOURCE_DIR}/docker-compose.yml --env-file ${CMAKE_CURRENT_BINARY_DIR}/.env build --parallel --progress=plain
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/docker-compose.yml
        COMMENT "Build the docker image ${THIS_TARGET}"
    )
endmacro()

#----------------------------------------------------------------------------
# Perform a docker start
# Parameters:
#   [IN] start_no_daemon (1 or 0) 1 = no daemon. default = daemon
#----------------------------------------------------------------------------
macro(docker_start interactive)

  # Add this to the run group
  add_dependencies(start_group ${THIS_TARGET}_start)
  add_custom_target(${THIS_TARGET}_start
      COMMENT "======== Starting ${THIS_TARGET} ========>"
  )

  # Start by bringing this container up
  add_custom_command(
    TARGET ${THIS_TARGET}_start
    COMMAND ${DOCKER_COMPOSE} -f ${CMAKE_CURRENT_SOURCE_DIR}/docker-compose.yml up -d
  )

  # If this is an interactive command, invoke it
  if ( ${interactive} )
    add_custom_command(
      TARGET ${THIS_TARGET}_start
      COMMAND ${DOCKER} exec -it ${CTR_NAME} ${EXEC_CMD}
      # Immediately close after you finish interacting
      COMMAND ${DOCKER_COMPOSE} -f ${CMAKE_CURRENT_SOURCE_DIR}/docker-compose.yml down
      )
  endif()

endmacro()

#----------------------------------------------------------------------------
# Perform a docker stop
#----------------------------------------------------------------------------
macro(docker_stop)
  # Add this to the stop group
  add_dependencies(stop_group ${THIS_TARGET}_stop)
  add_custom_target(${THIS_TARGET}_stop
      COMMENT "Stopping ${THIS_TARGET}"
  )
  add_custom_command(
      TARGET ${THIS_TARGET}_stop
      COMMAND ${DOCKER_COMPOSE} -f ${CMAKE_CURRENT_SOURCE_DIR}/docker-compose.yml down
  )
endmacro()

#----------------------------------------------------------------------------
# Perform a docker install
#----------------------------------------------------------------------------
macro(docker_install)
  # Commit the image
  install(
      CODE "execute_process(COMMAND docker image tag ${IMAGE_NAME} $ENV{DOCKER_REGISTRY}/${IMAGE_NAME})"
      CODE "execute_process(COMMAND docker push $ENV{DOCKER_REGISTRY}/${IMAGE_NAME})"
  )
endmacro()