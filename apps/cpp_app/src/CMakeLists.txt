project(hello_world)
cmake_minimum_required(VERSION 3.0)

set(CMAKE_GENERATOR Ninja)
file(GLOB SOURCE_FILE ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
add_executable(hello_world ${SOURCE_FILE})
