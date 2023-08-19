cmake_minimum_required(VERSION 3.18)
project(example LANGUAGES C CXX)

# Include CMX into the project
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake;")
include(cmx-bootstrap)

cmx_include_scripts() # Enable sanitizers and extended compiler warnings on supported platforms

# Define an application (example) and a static library (example-static) in one swoop
cmx_add_application(example "${CMAKE_CURRENT_SOURCE_DIR}/src")
target_include_directories(example PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_include_directories(example-static PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include")

# Define a unit testing target (using Google Test) to run with CTest
cmx_add_tests(example-tests "${CMAKE_CURRENT_SOURCE_DIR}/test")
target_link_libraries(example-tests PRIVATE example-static)
add_dependencies(example-tests example-static)
