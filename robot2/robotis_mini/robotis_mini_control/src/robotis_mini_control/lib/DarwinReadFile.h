/*

Code for GEI744, ROS and Darwin_Op robotic plateform.
Author: Guillaume Durandau, Guillaume.Durandau@Usherbrooke.ca
License: BSD

Vers: 0.0.1
Date: 06/02/14

*/

#ifndef DARWINREADFILE_H
#define DARWINREADFILE_H

#include "ros/ros.h"
#include <iostream>
#include <fstream>
#include <boost/regex.hpp>
#include <boost/algorithm/string.hpp>
#include <boost/lexical_cast.hpp>
#include <string>
#include <stdlib.h>

using namespace std;
using namespace boost;

class DarwinReadFile
{
public:
	DarwinReadFile(string file_name);
	double getTSV(int line, int col); // Tab-separated value
private:
	vector<vector<double> > joint_table_;
};

#endif
