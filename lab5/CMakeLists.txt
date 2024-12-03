cmake_minimum_required(VERSION 3.22.1)

project(OpenCVExample)

find_package(OpenCV REQUIRED)

include_directories( ${OpenCV_INCLUDE_DIRS} )

configure_file(${CMAKE_SOURCE_DIR}/haarcascade_frontalface_default.xml ${CMAKE_BINARY_DIR}/ COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/haarcascade_mcs_nose.xml ${CMAKE_BINARY_DIR}/ COPYONLY)

add_executable(OpenCVExample lab5.cpp)

target_link_libraries(OpenCVExample ${OpenCV_LIBS})
