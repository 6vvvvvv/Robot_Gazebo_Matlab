/*

Code for GEI744, ROS and Darwin_Op robotic plateform.
Author: Guillaume Durandau, Guillaume.Durandau@Usherbrooke.ca
License: BSD

Vers: 0.0.1
Date: 04/02/14

*/

#ifndef DARWINJOINTCONTROL_H
#define DARWINJOINTCONTROL_H

#include "ros/ros.h"
#include "std_msgs/Float64.h"
#include <string>
#include <map>
#include "DarwinJoint.h"


class DarwinJointControl
{
public:
	DarwinJointControl(ros::NodeHandle* node);
	double getJoint(std::string joint_name);
	void setJoint(std::string joint_name, double joint_send_value);
	void getNameOnScreen();
	void goalPos(std::string joint_name, double joint_send_value, ros::Duration time_tot, ros::Rate rate);
private:
	std::map<std::string, DarwinJoint*> joint_map_;
};

#endif
