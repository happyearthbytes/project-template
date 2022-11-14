project(leet_code)
cmake_minimum_required(VERSION 3.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_GENERATOR Ninja)
file(GLOB SOURCE_FILE ${CMAKE_CURRENT_SOURCE_DIR}/*mine.cpp)
add_executable(leet_code ${SOURCE_FILE})
