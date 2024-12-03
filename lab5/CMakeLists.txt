cmake_minimum_required(VERSION 3.22.1)

project(OpenCV_ClownNose)

find_package(OpenCV REQUIRED)

include_directories( ${OpenCV_INCLUDE_DIRS} )

configure_file(${CMAKE_SOURCE_DIR}/haarcascade_frontalface_default.xml ${CMAKE_BINARY_DIR}/ COPYONLY)
configure_file(${CMAKE_SOURCE_DIR}/haarcascade_mcs_nose.xml ${CMAKE_BINARY_DIR}/ COPYONLY)

add_executable(OpenCV_ClownNose lab5.cpp)

target_link_libraries(OpenCV_ClownNose ${OpenCV_LIBS})
