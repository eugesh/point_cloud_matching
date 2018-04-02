
add_executable (iterative_closest_point main.cpp)
target_link_libraries (iterative_closest_point ${PCL_LIBRARIES})

add_executable (interactive_icp interactive_icp.cpp)
target_link_libraries (interactive_icp ${PCL_LIBRARIES})