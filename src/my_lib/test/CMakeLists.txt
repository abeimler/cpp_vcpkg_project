add_executable(my_lib_tests "./tests.cpp")

target_link_libraries(
  my_lib_tests
  PRIVATE my_lib
          project_warnings
          project_options
          Catch2::Catch2 Catch2::Catch2WithMain)

# automatically discover tests that are defined in catch based test files you can modify the tests
catch_discover_tests(my_lib_tests ${CATCH_DISCOVER_TESTS_ARGS})

# constexpr tests
add_subdirectory("./constexpr")
