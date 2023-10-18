%% Reference:
%% https://github.com/gapaul/dobot_magician_driver 
%% I found this on google looking up Dobot Magician ROS Matlab, looks super useful pls look at it! :)
%% object detection 
%% https://au.mathworks.com/help/vision/ug/automate-ground-truth-labeling-for-object-detection.html
clear all;
clc;
close all; 
rosshutdown;


rosinit; %% starts dobot initian NODE 
dobot = DobotMagician; 

joint_target = [0.0, 0.0, 0.0, 0.0];
dobot.PublishJointTarget(joint_target);

end_effector_position = [0.0, 0.0, 0.0];
end_effector_rotation = [0,0,0];
dobot.PublishEndEffectorPose(end_effector_position, end_effector_rotation);