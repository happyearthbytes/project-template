###############################################################################
# Common Packaging configurations
###############################################################################
# https://cmake.org/cmake/help/v3.7/module/CPack.html

set( CPACK_GENERATOR                   "RPM" )
set( CPACK_PACKAGE_NAME                ${TOPLEVEL_PROJECT_NAME} )
set( CPACK_PACKAGE_VENDOR              ${TOPLEVEL_PACKAGE_VENDOR} )
set( CPACK_PACKAGE_HOMEPAGE_URL        ${TOPLEVEL_HOMEPAGE_URL} )
set( CPACK_PACKAGE_VERSION             ${TOPLEVEL_VERSION} )
set( CPACK_PACKAGE_RELEASE             ${TIMESTAMP} )
set( CPACK_PACKAGE_RELEASE             "0" ) #TODO
#set( CPACK_RESOURCE_FILE_LICENSE       ${TOPLEVEL_LICENSE_FILE} ) # TODO
#set( CPACK_RESOURCE_FILE_README        ${TOPLEVEL_README_FILE} ) # TODO
set( CPACK_PACKAGE_DESCRIPTION_SUMMARY ${TOPLEVEL_SUMMARY} )
set( CPACK_PACKAGE_DESCRIPTION         ${TOPLEVEL_SUMMARY} ) # TODO future use description file
set( PACKAGE_VERSION                   ${CPACK_PACKAGE_VERSION}-${CPACK_PACKAGE_RELEASE} )
set( CPACK_PACKAGE_FILE_NAME           "${CPACK_PACKAGE_NAME}-monolith-${PACKAGE_VERSION}.${OS_ARCH}" )
set( CPACK_SOURCE_PACKAGE_FILE_NAME    "${CPACK_PACKAGE_NAME}-src-${PACKAGE_VERSION}.${OS_ARCH}" )
set( CPACK_PACKAGE_DIRECTORY           ${CMAKE_BINARY_DIR}/packages )
set( CPACK_PACKAGE_RELOCATABLE         ON )
set( CPACK_PACKAGING_INSTALL_PREFIX    ${CMAKE_INSTALL_PREFIX} )
#set( CPACK_COMPONENTS_IGNORE_GROUPS    1 ) #TODO
set( CPACK_COMPONENTS_GROUPING         IGNORE ) # ONE_PER_GROUP
#set( CPACK_COMPONENTS_GROUPING         ONE_PER_GROUP ) # ONE_PER_GROUP

###############################################################################
# Common RPM configurations
###############################################################################
set( CPACK_RPM_PACKAGE_DEBUG           OFF )
set( CPACK_RPM_COMPONENT_INSTALL       ON  )
set( CPACK_RPM_DEFAULT_DIR_PERMISSIONS ${CMAKE_INSTALL_DEFAULT_DIRECTORY_PERMISSIONS} )
set( CPACK_RPM_INSTALL_WITH_EXEC       ON  )
set( CPACK_RPM_PACKAGE_DESCRIPTION     ${CPACK_PACKAGE_DESCRIPTION} )
set( CPACK_RPM_PACKAGE_GROUP           "Development/Libraries" )
set( CPACK_RPM_PACKAGE_LICENSE         ${TOPLEVEL_LICENSE} )
set( CPACK_RPM_PACKAGE_RELEASE         ${CPACK_PACKAGE_RELEASE} )
set( CPACK_RPM_CHANGELOG_FILE          ${TOPLEVEL_CHANGELOG_FILE})
# TODO
set( CPACK_RPM_PRE_INSTALL_SCRIPT_FILE    "")
set( CPACK_RPM_PRE_UNINSTALL_SCRIPT_FILE  "")
set( CPACK_RPM_POST_INSTALL_SCRIPT_FILE   "")
set( CPACK_RPM_POST_UNINSTALL_SCRIPT_FILE "")

# Common SRPM configurations
#==============================================================================
#set( CPACK_RPM_PACKAGE_SOURCES         ON ) # TODO This causes issues when enabled
# Note that this appears to be installing everything
#set( CPACK_INSTALLED_DIRECTORIES       ${CMAKE_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR} )
#set( CPACK_SOURCE_GENERATOR            "RPM" )

# CPack Basic
#==============================================================================
# TODO
#set(CPACK_INSTALL_CMAKE_PROJECTS "${CMAKE_CURRENT_BINARY_DIR};${CMAKE_PROJECT_NAME};ALL;/")

###############################################################################
# Examples
###############################################################################


# Notes
#==============================================================================

# Note include(CPack) should only occur once after all CPACK variables have been set
# After include(CPack), then add cpack_add_component
