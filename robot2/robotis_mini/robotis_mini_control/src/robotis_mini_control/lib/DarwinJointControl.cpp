/*

Code for GEI744, ROS and Darwin_Op robotic plateform.
Author: Guillaume Durandau, Guillaume.Durandau@Usherbrooke.ca
License: BSD

Vers: 0.0.1
Date: 04/02/14

*/

#include "DarwinJointControl.h"

DarwinJointControl::DarwinJointControl(ros::NodeHandle* node)
{
	bool init_joint = false;
	bool temp = true;
	XmlRpc::XmlRpcValue list_joint_name;
	if(node->getParam("/robotis_mini/joint_list", list_joint_name))
	{
		ROS_ASSERT(list_joint_name.getType() == XmlRpc::XmlRpcValue::TypeArray);
		for (int i = 0; i < list_joint_name.size(); ++i)
			joint_map_[static_cast<std::string>(list_joint_name[i])] = new DarwinJoint(static_cast<std::string>(list_joint_name[i]), node, 50);
	}
	else
		ROS_ERROR("Get ros_param not found");
	
	std::map<std::string, DarwinJoint*>::iterator it;
	
	while (ros::ok())
	{
		for(it = joint_map_.begin(); it != joint_map_.end(); ++it)
		{
			temp = temp and it->second->initEnd();
			ros::spinOnce();
			if(!it->second->initEnd())
				ROS_INFO("%s", it->second->getName().c_str());
		}
		!temp ? temp = true : init_joint = true ;
				
		if(init_joint)
		{
			break;
			ROS_INFO("Initialisation end");
		}
	}
}

double DarwinJointControl::getJoint(std::string joint_name)
{
	std::map<std::string, DarwinJoint*>::iterator it;
	it = joint_map_.find(joint_name);
	if(it != joint_map_.end())
		return it->second->getJoint();
	else
	{
		ROS_ERROR("Joint name not found !");
		return 0;
	}
}

void DarwinJointControl::setJoint(std::string joint_name, double joint_send_value)
{
	std::map<std::string, DarwinJoint*>::iterator it;
	it = joint_map_.find(joint_name);
	if(it != joint_map_.end())
		it->second->setJoint(joint_send_value);
	else
		ROS_ERROR("joint name not found !");
}

void DarwinJointControl::getNameOnScreen()
{
	std::map<std::string, DarwinJoint*>::iterator it;
	/*for(it = joint_map_.begin(); it != joint_map_.end(); ++it)
		ROS_INFO("Joint: %s", it->first.c_str());
	*/
}


void DarwinJointControl::goalPos(std::string joint_name, double joint_send_value, ros::Duration time_tot, ros::Rate rate)
{
	/*double val_j = getJoint(joint_name);
	double nb_mor = time_tot.toSec()/dt.toSec();
	double j_pos_mor = (joint_send_value - val_j)/nb_mor;
	for(int i = 0; i < nb_mor ; i++)
	{
		val_j += j_pos_mor;
		setJoint(joint_name, val_j);
		dt.sleep();
	}*/ //extrapolation lineaire
	joint_map_[joint_name]->goalPos(joint_send_value, time_tot, rate);
}
