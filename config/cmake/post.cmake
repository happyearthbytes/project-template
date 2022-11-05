###############################################################################T
# READ VARIABLES
###############################################################################


###############################################################################
# DEFINE COMPONENTS
###############################################################################
# https://nebula-graph.io/posts/packaging-with-cpack-in-nebula-graph/
# http://shadow.nd.rl.ac.uk/ICP_Binaries/CMake/doc/cmake/html/module/CPackComponent.html
# http://cmake.3232098.n2.nabble.com/CPack-Create-debian-packge-for-each-sub-project-td7595889.html
# https://cmake.cmake.narkive.com/8rPSqk6E/cpack-rpm-generator-not-using-cpack-rpm-component-xxx-variables
set( CPACK_RPM_HW_COMPONENT_PACKAGE_NAME     "test_name" )
set( CPACK_RPM_HW_COMPONENT_PACKAGE_SUMMARY  "test_summary" )
set( CPACK_RPM_HW_COMPONENT_FILE_NAME        "test_filename" )

cpack_add_component( hello_world
  DISPLAY_NAME "hello world component"
  DESCRIPTION "the component for hello world"
  GROUP BASIC_GROUP
  INSTALL_TYPES BASIC_INSTALL
)

cpack_add_component( HC_COMPONENT
  DISPLAY_NAME "hello class component"
  DESCRIPTION "the component for hello class"
  GROUP BASIC_GROUP
  INSTALL_TYPES BASIC_INSTALL
)

cpack_add_component( HL_COMPONENT
  DISPLAY_NAME "hello class component"
  DESCRIPTION "the component for hello class"
  GROUP BASIC_GROUP
  INSTALL_TYPES BASIC_INSTALL
)

cpack_add_install_type( BASIC_INSTALL
  DISPLAY_NAME "The basic installation type")

cpack_add_component_group( BASIC_GROUP
  DISPLAY_NAME "The basic group type"
)

set( CPACK_RPM_HW_COMPONENT_PACKAGE_NAME     "test_name" )
set( CPACK_RPM_HW_COMPONENT_PACKAGE_SUMMARY  "test_summary" )
set( CPACK_RPM_HW_COMPONENT_FILE_NAME        "test_filename" )