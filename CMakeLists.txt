cmake_minimum_required(VERSION 3.18)
project(example LANGUAGES C CXX)

# Include CMX into the project
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake;")
include(Cmx)

cmx_include_scripts() # Enable sanitizers and extended compiler warnings on supported platforms

# Define an application (example) and a static library (example-static) in one swoop
cmx_add_application(example "${CMAKE_SOURCE_DIR}/src")

# Define a unit testing target (using Google Test) to run with CTest
cmx_add_tests(example-tests "${CMAKE_SOURCE_DIR}/test")
target_include_directories(example-tests PRIVATE "${CMAKE_SOURCE_DIR}/include")
target_link_libraries(example-tests PRIVATE example-static)
add_dependencies(example-tests example-static)