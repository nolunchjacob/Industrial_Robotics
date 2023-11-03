function dobot_test

clear all;
clc
axis equal;
hold on;


% visualize_and_analyze_robot_test;
% Initialize the robot and set the base transformation matrix
baseTr = transl([0, 0, 0.5]) * trotx(0) * troty(0) * trotz(pi/2);

robot = DobotMagician(baseTr);

axis([-1, 1, -1, 1, -0.1, 1]);

q_s = [-90, 55, 60, 65, 0];
% keyboard;
% Set the initial positions for the robot and the coin
q_startpos = robot.model.ikcon(transl(0.3, 0, 0.6), q_s);



% pos_coin1 = [-0.35, -0.35, 0.533];
pos_coin1 = [0, 0.275, 0.5];
pos_coin2 = [-0.275, 0, 0.5];

% initial joint coordinates q0 used for the minimisation.
q1 = [0, 75, 70, 35, 0];
q2 = [90, 75, 70, 35, 0];

% Initialize the coin's position and create the coin model
coin1 = fivecentcoin_pos(pos_coin1);
coin2 = fivecentcoin_pos(pos_coin2);

% Use inverse kinematics to find the desired joint angles for the coin's pickup

coin_pickup1 = robot.model.ikcon(transl(pos_coin1), q1);
coin_pickup2 = robot.model.ikcon(transl(pos_coin2), q2);


% Use inverse kinematics to find the desired joint angles for the coin drop-off
coin_drop1 = robot.model.ikcon(transl(0.3, 0.2, 0.6), q_s);


q_handoff = [90 45 45 0 0];
coin_drop2 = robot.model.ikcon(transl(-0.292, 0, 0.795), q_handoff);


% Generate trajectories for robot movement and coin movement
robot_to_coin_trajectory1 = jtraj(q_startpos, coin_pickup1, 50);
coin_to_dropoff_trajectory1 = jtraj(coin_pickup1, coin_drop1, 50);

robot_to_coin_trajectory2 = jtraj(coin_drop1, coin_pickup2, 50);
coin_to_dropoff_trajectory2 = jtraj(coin_pickup2, coin_drop2, 50);


% Animate the robot's motion to the coin's pickup position
for i = 1:size(robot_to_coin_trajectory1, 1)
    robot.model.animate(robot_to_coin_trajectory1(i, :));
    drawnow;
    pause(0.1);
end


% Animate the robot's motion with the coin to the drop-off position
for i = 1:size(coin_to_dropoff_trajectory1, 1)
    % Get the end effector position
    endEffectorPos = robot.model.fkine(coin_to_dropoff_trajectory1(i, :)).T;

    % Extract the translation vector (position) from the transformation matrix
    coin_pos = endEffectorPos(1:3, 4);

    % Delete the previous coin
    delete(coin1);

    % Create a new coin at the updated position
    coin1 = fivecentcoin_pos(coin_pos);

    % Animate the robot
    robot.model.animate(coin_to_dropoff_trajectory1(i, :));
    drawnow;
    pause(0.1);

end
delete(coin1);


% Animate the robot's motion to the coin's pickup position
for i = 1:size(robot_to_coin_trajectory2, 1)
    robot.model.animate(robot_to_coin_trajectory2(i, :));
    drawnow;
    pause(0.1);
end

% Animate the robot's motion with the coin to the drop-off position
for i = 1:size(coin_to_dropoff_trajectory2, 1)
    % Get the end effector position
    endEffectorPos = robot.model.fkine(coin_to_dropoff_trajectory2(i, :)).T;
    
    % Extract the translation vector (position) from the transformation matrix
    coin_pos = endEffectorPos(1:3, 4);
    
    % Delete the previous coin
    delete(coin2);
    
    % Create a new coin at the updated position
    coin2 = fivecentcoin_pos(coin_pos);
    
    % Animate the robot
    robot.model.animate(coin_to_dropoff_trajectory2(i, :));
    drawnow;
    pause(0.1);

end

delete(coin2);
