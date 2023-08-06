cmake_minimum_required(VERSION 3.18)
project(example LANGUAGES C CXX)

# Default to C++20 if not explicitly specified otherwise
if(NOT DEFINED CMAKE_CXX_STANDARD)
    message(STATUS "No C++ version specified, defaulting to C++20")
    set(CMAKE_CXX_STANDARD 20)
endif()

# Include CMake modules in ./cmake/
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake;")
include(CmxPlatform)
include(CmxScripts)
include(CmxApplication)
cmx_include_scripts() # Enable sanitizers on supported platforms and extend compiler warnings

# Executable
cmx_add_application(example "${CMAKE_SOURCE_DIR}/src" "${CMAKE_SOURCE_DIR}/include")

# Unit testing
file(GLOB_RECURSE TEST_SOURCE_FILES "${CMAKE_SOURCE_DIR}/test/*.cpp")
add_executable(example-tests "${TEST_SOURCE_FILES}")
target_include_directories(example-tests PRIVATE "${CMAKE_SOURCE_DIR}/include")
target_include_gtest(example-tests)
target_link_libraries(example-tests PRIVATE example-static)
add_dependencies(example-tests example-static)
