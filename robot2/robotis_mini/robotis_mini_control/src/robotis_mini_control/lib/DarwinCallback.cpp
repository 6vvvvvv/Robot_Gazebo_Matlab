#include "DarwinCallback.h"

msg_struct DarwinCallback::msg_data;

DarwinCallback::DarwinCallback(NodeHandle* node, string name_joint)
{
	ROS_INFO("Create Publisher for %s", name_joint.c_str());
	name_joint_ = name_joint;
	std::ostringstream joint_name_state_;
	joint_name_state_<< "/robotis_mini/" << name_joint_.c_str() << "_position_controller/command";
	sub_ = node->subscribe(joint_name_state_.str().c_str(), 10, &DarwinCallback::callback, this);
}

void DarwinCallback::callback(const std_msgs::Float64::ConstPtr& msg_in)
{
	msg_data.mutex_.lock();
	msg_data.data[name_joint_] = msg_in->data;
	msg_data.mutex_.unlock();
}
