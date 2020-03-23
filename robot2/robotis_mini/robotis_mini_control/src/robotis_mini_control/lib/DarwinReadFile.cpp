/*

Code for GEI744, ROS and Darwin_Op robotic plateform.
Author: Guillaume Durandau, Guillaume.Durandau@Usherbrooke.ca
License: BSD

Vers: 0.0.1
Date: 06/02/14

*/

#include "DarwinReadFile.h"

DarwinReadFile::DarwinReadFile(string file_name)
{
	string line;
	vector<string> line_vector;
	std::ifstream file(file_name.c_str(), ios::in);
	if(file)
	{
		while(getline(file, line))
		{
			split(line_vector,line,is_any_of("\t"));
			vector<double> line_double;
			for(int i = 0; i < line_vector.size(); i++)
				line_double.push_back(atof(line_vector[i].c_str()));

			joint_table_.push_back(line_double);
		}
		file.close();
	}
	else
		ROS_ERROR("File not found");
}

double DarwinReadFile::getTSV(int line, int col)
{
	return joint_table_[line][col];
}



