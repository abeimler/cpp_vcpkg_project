include(CMakeDependentOption)
include(cmake/EnumOption.cmake)

# building the tests
option(FEATURE_TESTS "Enable the tests" OFF)
if(FEATURE_TESTS)
  list(APPEND VCPKG_MANIFEST_FEATURES "tests")
endif()
# constexpr tests
cmake_dependent_option(FEATURE_CONSTEXPR_TESTS "Enable constexpr Test Builds" ON FEATURE_TESTS OFF)
# fuzz tests
option(FEATURE_FUZZ_TESTS "Enable the fuzz tests" OFF)

# building the docs
option(FEATURE_DOCS "Enable the docs" OFF)

option(ENABLE_CROSS_COMPILING "Detect cross compiler and setup toolchain" OFF)
