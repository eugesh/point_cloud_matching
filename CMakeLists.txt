cmake_minimum_required (VERSION 3.5)

project (iterative_closest_point LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
include (FindPkgConfig)

if (NOT CMAKE_BUILD_TYPE)
  set (CMAKE_BUILD_TYPE "Release")
endif ()

if (${CMAKE_CXX_COMPILER_ID} STREQUAL GNU OR ${CMAKE_CXX_COMPILER_ID} STREQUAL Clang)
#  set (CXX_FLAGS "-std=c++11 -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers $ENV{CXXFLAGS}")
  set (CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O2 ${CXX_FLAGS}")
  set (CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O1 ${CXX_FLAGS}")
  set (MATH_LIBRARIES m)
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC)
  set (CXX_FLAGS "/std:c++latest /wd4244 /wd4305 $ENV{CXXFLAGS}")
  set (CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} ${CXX_FLAGS}")
  set (CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} ${CXX_FLAGS}")
else ()
  message (FATAL_ERROR "Unsupported compiler ${CMAKE_CXX_COMPILER_ID}")
endif ()

if (NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
  set (CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")
  set (CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_CURRENT_SOURCE_DIR}/bin")
  set (CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG "${CMAKE_CURRENT_SOURCE_DIR}/bin")
endif ()

if (NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
  set (CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")
  set (CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_CURRENT_SOURCE_DIR}/bin")
  set (CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_CURRENT_SOURCE_DIR}/bin")
endif ()

if (NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
  set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")
  set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${CMAKE_CURRENT_SOURCE_DIR}/bin")
  set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${CMAKE_CURRENT_SOURCE_DIR}/bin")
endif ()


#find_package( OpenCV REQUIRED )

#IF(NOT OpenCV_FOUND)
#    MESSAGE(FATAL_ERROR "OpenCV not found")
#ENDIF()
#set(OpenCV_LIBS opencv_core opencv_highgui opencv_imgproc opencv_videoio opencv_contrib opencv_calib3d opencv_features2d opencv_flann opencv_photo)

#include_directories( ${OpenCV_INCLUDE_DIRS} )

#if(CMAKE_VERSION VERSION_LESS "2.8.11")
#    include_directories(${OpenCV_INCLUDE_DIRS})
#endif()

find_package(PCL REQUIRED)

#set(PCL_INCLUDE_DIRS /usr/include/pcl-1.8/pcl)
if (UNIX)
set(PCL_INCLUDE_DIRS /usr/include/pcl-1.10)
endif (UNIX)

include_directories(${PCL_INCLUDE_DIRS})
link_directories(${PCL_LIBRARY_DIRS})
add_definitions(${PCL_DEFINITIONS})

#set (QTLIBS QtGui QtCore QtNetwork)
#find_package (Qt4 REQUIRED)
# qt4_wrap_cpp (MOC_SOURCES ${HEADERS})
#include(${QT_USE_FILE})

#include (findeigen3)
#find_package (Eigen3 REQUIRED)
#include_directories (${EIGEN3_INCLUDE_DIR})

link_directories ("${CMAKE_CURRENT_SOURCE_DIR}/../bin")
set (ADDON_LIBRARIES ${ADDON_LIBRARIES})

add_subdirectory ("cpp")
