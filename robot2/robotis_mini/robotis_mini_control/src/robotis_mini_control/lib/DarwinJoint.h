/*

Code for GEI744, ROS and Darwin_Op robotic plateform.
Author: Guillaume Durandau, Guillaume.Durandau@Usherbrooke.ca
License: BSD

Vers: 0.0.1
Date: 04/02/14

*/

#ifndef DARWINJOINT_H
#define DARWINJOINT_H

#include "ros/ros.h"
#include "std_msgs/Float64.h"
#include "control_msgs/JointControllerState.h"
#include <string>
#include <boost/thread/thread.hpp>
#include <boost/thread/mutex.hpp>
#include <cmath>


using namespace std;

class DarwinJoint
{
public:
	DarwinJoint(std::string joint_name, ros::NodeHandle* node_main, int rate);
	~DarwinJoint();
	double getJoint();
	std::string getName();
	void setJoint(double joint_send_value);
	bool initEnd();
	void goalPos(double j_val, ros::Duration tf, ros::Rate rate);
private:
	void darwinCallback(const control_msgs::JointControllerState::ConstPtr& msg_in); /* Callback function for the subscriber */
	void pubThread(int rate); /* Thread function */
	void goalPosThread(double j_val, ros::Duration tf, ros::Rate rate);
	boost::mutex mutex_; /* Mutex for thread */
	double send_value_; /* Value for thread and main */
	boost::thread* thread_pub_; /* Thread for the publisher TODO: supprimer thread pour publisher et l'appller adns la classe supp*/
	boost::thread* thread_goal_; /* Thread for the goal position function */
	ros::Publisher joint_pub_; /* publisher of the ROS message in the thread */
	ros::Subscriber joint_sub_; /* Subscriber for  knowing the state of the joint */
	std_msgs::Float64 msg_out_; /* Message for the publisher in the thread */
	std::string darwin_joint_name_; /* Name of the joint in this class */
	double joint_value_; /* Value of the joint */
	bool stop_thread_; /* Bool for kill the thread */
	bool first_msg;
	int rate_;

};

#endif
