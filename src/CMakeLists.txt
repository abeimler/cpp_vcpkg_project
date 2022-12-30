if(FEATURE_TESTS)
  #find_package(GTest CONFIG REQUIRED)
  find_package(Catch2 CONFIG REQUIRED)
  include(Catch)
  # FIXME: "xml" is not a valid reporter!
  # use xml reporter if coverage is enabled
  #if(${ENABLE_COVERAGE})
  #  set(CATCH_DISCOVER_TESTS_ARGS REPORTER xml)
  #endif()
endif()
if(FEATURE_BENCHMARKS)
  find_package(benchmark CONFIG REQUIRED)
endif()

# NOTE: add more sub projects here
add_subdirectory(my_header_lib)
add_subdirectory(my_lib)
add_subdirectory(my_exe)


# install
if(CMAKE_SKIP_INSTALL_RULES)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  return()
endif()

set(CPACK_SOURCE_IGNORE_FILES
    "~$;[.]swp$;/[.]git/;/[.]clangd/;/[.]cache/;[.]vscode/;.gitignore;/build*;/obj*;tags;cscope.*;compile_commands.json;.*\.patch")
#set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/README.md")
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
set(CPACK_PACKAGE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

# TODO: use packageProject from TheLartians/PackageProject.cmake
# Package the project
package_project(
  TARGETS
  my_exe
  my_lib
  my_header_lib
  project_options
  project_warnings
  INTERFACE_DEPENDENCIES_CONFIGURED
  ${my_header_lib_DEPENDENCIES_CONFIGURED}
  INTERFACE_INCLUDES
  ${my_header_lib_INCLUDE_DIR}
  PUBLIC_INCLUDES
  ${my_lib_INCLUDE_DIR})


# Experience shows that explicit package naming can help make it easier to sort out potential ABI related issues before they start, while
# helping you track a build to a specific GIT SHA
set(CPACK_PACKAGE_FILE_NAME
    "${CMAKE_PROJECT_NAME}-${CMAKE_PROJECT_VERSION}-${CMAKE_SYSTEM_NAME}-${CMAKE_BUILD_TYPE}-${CMAKE_CXX_COMPILER_ID}-${CMAKE_CXX_COMPILER_VERSION}"
)

include(CPack)
message(STATUS "setup CPack for ${CMAKE_PROJECT_NAME}")