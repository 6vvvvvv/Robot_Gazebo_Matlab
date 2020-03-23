cmake_minimum_required(VERSION 2.8.3)
project(robotis_mini_control)

find_package(catkin REQUIRED COMPONENTS
 control_msgs
  controller_manager
  effort_controllers
  roscpp
  rospy
  std_msgs
  geometry_msgs
  sensor_msgs
  #robotis_mini_description
  #gazebo_msgs
  #gazebo_plugins
  #gazebo_ros
  #gazebo_ros_control
)

find_package(Boost REQUIRED COMPONENTS system thread)


catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES darwin_control
#  CATKIN_DEPENDS controller_manager effort_controllers
#  DEPENDS system_lib
  DEPENDS
    Boost
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)


## Declare a cpp library
 add_library(robotis_mini_GEI744
	 src/robotis_mini_control/lib/DarwinJoint.cpp src/robotis_mini_control/lib/DarwinJointControl.cpp src/robotis_mini_control/lib/DarwinReadFile.cpp src/robotis_mini_control/lib/DarwinCallback.cpp ${catkin_LIBRARIES}
 )
 target_link_libraries(robotis_mini_GEI744
	${catkin_LIBRARIES}
 )

## Declare a cpp executable
 add_executable(Robotis_Mini_Joint_Control_node src/robotis_mini_control/main.cpp)


## Add cmake target dependencies of the executable/library
## as an example, message headers may need to be generated before nodes
# add_dependencies(Darwin_Joint_Control_node darwin_control_generate_messages_cpp)

## Specify libraries to link a library or executable target against
 target_link_libraries(Robotis_Mini_Joint_Control_node robotis_mini_GEI744
   ${catkin_LIBRARIES}
 )


