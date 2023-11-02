clear all;
clc

% Initialize the robot and set the base transformation matrix
baseTr = transl([0, 0, 0]) * trotx(0) * troty(0) * trotz(0);
% robot = DobotMagician(baseTr);
robot = UR3(baseTr);

% Set the initial positions for the robot and the coin
q_startpos = robot.model.ikcon(transl(0.2, 0, 0.1));
pos_coin1 = [0.25, 0, 0];

% Initialize the coin's position and create the coin model
coin = fivecentcoin_pos(pos_coin1);

% Use inverse kinematics to find the desired joint angles for the coin's pickup
coin_pickup = robot.model.ikcon(transl(pos_coin1) * trotx(pi));

% Use inverse kinematics to find the desired joint angles for the coin drop-off
coin_drop = robot.model.ikcon(transl(0.2, 0, 0.2) * trotx(pi));

% Generate trajectories for robot movement and coin movement
robot_to_coin_trajectory = jtraj(q_startpos, coin_pickup, 50);
coin_to_dropoff_trajectory = jtraj(coin_pickup, coin_drop, 50);

% Animate the robot's motion to the coin's pickup position
for i = 1:size(robot_to_coin_trajectory, 1)
    robot.model.animate(robot_to_coin_trajectory(i, :));
    drawnow;
    pause(0.1);
end

% Animate the robot's motion with the coin to the drop-off position
for i = 1:size(coin_to_dropoff_trajectory, 1)
    % Get the end effector position
    endEffectorPos = robot.model.fkine(coin_to_dropoff_trajectory(i, :)).T;
    
    % Extract the translation vector (position) from the transformation matrix
    coin_pos = endEffectorPos(1:3, 4);
    
    % Delete the previous coin
    delete(coin);
    
    % Create a new coin at the updated position
    coin = fivecentcoin_pos(coin_pos);
    
    % Animate the robot
    robot.model.animate(coin_to_dropoff_trajectory(i, :));
    drawnow;
    pause(0.1);
end





