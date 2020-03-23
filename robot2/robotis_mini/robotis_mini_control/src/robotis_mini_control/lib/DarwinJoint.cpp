/*

Code for GEI744, ROS and Darwin_Op robotic plateform.
Author: Guillaume Durandau, Guillaume.Durandau@Usherbrooke.ca
License: BSD

Vers: 0.0.1
Date: 04/02/14

*/

#include "DarwinJoint.h"


DarwinJoint::DarwinJoint(std::string joint_name, ros::NodeHandle* node, int rate)
{
	darwin_joint_name_ = joint_name;
	std::ostringstream joint_name_command_;
	std::ostringstream joint_name_state_;
	
	joint_name_command_ << "/robotis_mini/" << darwin_joint_name_.c_str() << "_position_controller/command";
	joint_name_state_ << "/robotis_mini/" << darwin_joint_name_.c_str() << "_position_controller/state";
	
	rate_ = rate;
	stop_thread_ = false;
	first_msg = false;
	
	joint_pub_ = node->advertise<std_msgs::Float64>(joint_name_command_.str().c_str(), 1000);
	joint_sub_ = node->subscribe(joint_name_state_.str().c_str(), 1000, &DarwinJoint::darwinCallback, this);
}

DarwinJoint::~DarwinJoint()
{
	mutex_.lock();
	stop_thread_ = true;
	mutex_.unlock();
}

double DarwinJoint::getJoint()
{
	return joint_value_;
}

std::string DarwinJoint::getName()
{
	return darwin_joint_name_.c_str();
}

void DarwinJoint::setJoint(double joint_send_value)
{
	mutex_.lock();
	send_value_ = joint_send_value;
	mutex_.unlock();
	ROS_INFO("Joint %s just send: %f", darwin_joint_name_.c_str(), joint_send_value);
}

bool DarwinJoint::initEnd()
{
	return first_msg;
}

void DarwinJoint::darwinCallback(const control_msgs::JointControllerState::ConstPtr& msg_in)
{
	joint_value_ = msg_in->set_point;
	if(!first_msg)
	{
		send_value_ = joint_value_;
		thread_pub_ = new boost::thread(&DarwinJoint::pubThread, this, rate_);
		first_msg = true;
		ROS_DEBUG("Start thread");
	}
}

void DarwinJoint::pubThread(int rate)
{
	bool kill_me = false;
	ros::Rate loop_rate(rate);
	while (ros::ok())
	{
		mutex_.lock();
		msg_out_.data = send_value_;
		kill_me = stop_thread_;
		mutex_.unlock();
	
		joint_pub_.publish(msg_out_);

		ros::spinOnce();
		
		loop_rate.sleep();
		
		if(kill_me)
			break;
	}
}

void DarwinJoint::goalPos(double j_val, ros::Duration tf, ros::Rate rate)
{
	thread_goal_ = new boost::thread(&DarwinJoint::goalPosThread, this, j_val, tf, rate);
}

void DarwinJoint::goalPosThread(double j_fin, ros::Duration tf, ros::Rate rate)
{
	ros::Time t_init = ros::Time::now();
	double j_init = getJoint();
	double val;
	double a2 = (3 / pow(tf.toSec(), 2)) * (j_fin - j_init);
	double a3 = - (2 / pow(tf.toSec(), 3)) * (j_fin - j_init);
	while(ros::ok())
	{
		val = j_init + a2 * pow((ros::Time::now().toSec() - t_init.toSec()), 2) + a3 * pow((ros::Time::now().toSec() - t_init.toSec()), 3); // extrapolation cubique
		setJoint(val);
		if((ros::Time::now().toSec() - t_init.toSec() ) >= tf.toSec()) 
			break;
		rate.sleep();
	}
}

