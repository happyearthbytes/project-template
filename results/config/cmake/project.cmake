###############################################################################T
# READ VARIABLES
###############################################################################

# These custom targets will be used to define a set of target groups will
# be added as dependencies of these such that building these targets
# will build all of the sub targets
add_custom_target( build_group        COMMENT "Generating build" )
add_custom_target( start_group        COMMENT "Generating start" )
add_custom_target( stop_group         COMMENT "Generating stop" )
add_custom_target( test_group         COMMENT "Generating test" )
add_custom_target( scan_group         COMMENT "Generating scan" )
add_custom_target( docs_group         COMMENT "Generating docs" )
add_custom_target( verify_group       COMMENT "Generating verify" )

# Run all of the top level targets that are defined
if ( TARGETS MATCHES "ALL" OR NOT DEFINED TARGETS OR "${TARGETS}" STREQUAL "" )
  include(cmake/targets.cmake)
else()
  # Add subdirectories based on input TARGETS
  foreach(TARGET ${TARGETS})
    add_subdirectory_print("${TARGET}")
  endforeach()
endif()