#ifndef DARWIN_CALLBACK_H
#define DARWIN_CALLBACK_H

#include "ros/ros.h"
#include "std_msgs/Float64.h"
#include "sensor_msgs/JointState.h"
#include <string>
#include <map>
#include <boost/thread/mutex.hpp>

using namespace ros;
using namespace std;

typedef struct msg_struct {
    map<string, double> data;
    boost::mutex mutex_;
} msg_struct;

class DarwinCallback
{
public:
	DarwinCallback(NodeHandle* node, string name_joint);
	void callback(const std_msgs::Float64::ConstPtr& msg_in);
	static msg_struct msg_data;
private:
	//Publisher pub_;
	Subscriber sub_;
	string name_joint_;
};

#endif
