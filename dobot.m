clear all;
clc


hold on;
% visualize_and_analyze_robot_test;
% axis([-2, 3, -2, 2, 0, 2]); % Set axis limits to match your robot's workspace
% baseTr = transl([-0.5, 0, 0.5]) * trotx(0) * troty(0) * trotz(0);
baseTr = transl([-0.5, 0, 0]) * trotx(0) * troty(0) * trotz(0);
    robot = DobotMagician(baseTr);
    q = robot.model.getpos();
    robot.model.fkine(q);
% Define position vectors for q1 to q9 (adjust the values as needed)
    pos_coin1 = [-0.3, -0.2, 0];
    pos_coin2 = [-0.4, -0.2, 0];
    pos_coin3 = [-0.5, -0.2, 0];
    pos_coin4 = [-0.3, 0.2, 0];
    pos_coin5 = [-0.4, 0.2, 0];
    pos_coin6 = [-0.5, 0.2, 0];


    % % Call brick_pos function with each position vector to place bricks
    fivecentcoin_pos(pos_coin1);
    fivecentcoin_pos(pos_coin2);
    fivecentcoin_pos(pos_coin3);
    fivecentcoin_pos(pos_coin4);
    fivecentcoin_pos(pos_coin5);
    fivecentcoin_pos(pos_coin6);

% keyboard;

% Define a trajectory of joint configurations
q_startpos = robot.model.ikcon(transl(-0.2, 0, 0.1));
q1 = robot.model.ikcon(transl(pos_coin1) * trotx(pi));
q2 = robot.model.ikcon(transl(pos_coin2) * trotx(pi));
q3 = robot.model.ikcon(transl(pos_coin3) * trotx(pi)); 
q4 = robot.model.ikcon(transl(pos_coin4) * trotx(pi));
q5 = robot.model.ikcon(transl(pos_coin5) * trotx(pi));
q6 = robot.model.ikcon(transl(pos_coin6) * trotx(pi));


%drop off positions
q_drop = robot.model.ikcon(transl(-0.3, 0, 0.1) * trotx(pi));


trajectory1 = jtraj(q_startpos, q1, 50);
trajdrop1 = jtraj(q1,q_drop, 50);

trajectory2 = jtraj(q_drop, q2, 50); 
trajdrop2 = jtraj(q2, q_drop, 50);

trajectory3 = jtraj(q_drop, q3, 50);
trajdrop3 = jtraj(q3, q_drop, 50);

trajectory4 = jtraj(q_drop, q4, 50);
trajdrop4 = jtraj(q4, q_drop, 50);

trajectory5 = jtraj(q_drop, q5, 50);
trajdrop5 = jtraj(q5, q_drop, 50);

trajectory6 = jtraj(q_drop, q6, 50);
trajdrop6 = jtraj(q6, q_drop, 50);




% Animate the robot's motion along the trajectory
for i = 1:size(trajectory1, 1)
    robot.model.animate(trajectory1(i, :));
    drawnow;
    pause(0.1);
    
end
disp(['Forward Kinematics:'])
disp(robot.model.fkine(robot.model.getpos()));

for i = 1:size(trajdrop1, 1)
    robot.model.animate(trajdrop1(i, :));
    drawnow;
    pause(0.1);
    
end


for i = 1:size(trajectory2, 1)
    robot.model.animate(trajectory2(i, :));
    drawnow;
    pause(0.1);
end
disp(['Forward Kinematics:'])
disp(robot.model.fkine(robot.model.getpos()));

for i = 1:size(trajdrop2, 1)
    robot.model.animate(trajdrop2(i, :));
    drawnow;
    pause(0.1);
    
end
disp(['Forward Kinematics:'])
disp(robot.model.fkine(robot.model.getpos()));



for i = 1:size(trajectory3, 1)
    robot.model.animate(trajectory3(i, :));
    drawnow;
    pause(0.1);
end
disp(['Forward Kinematics:'])
disp(robot.model.fkine(robot.model.getpos()));

for i = 1:size(trajdrop3, 1)
    robot.model.animate(trajdrop3(i, :));
    drawnow;
    pause(0.1);
    
end
disp(['Forward Kinematics:'])
disp(robot.model.fkine(robot.model.getpos()));




for i = 1:size(trajectory4, 1)
    robot.model.animate(trajectory4(i, :));
    drawnow;
    pause(0.1);
end
disp(['Forward Kinematics:'])
disp(robot.model.fkine(robot.model.getpos()));


for i = 1:size(trajdrop4, 1)
    robot.model.animate(trajdrop4(i, :));
    drawnow;
    pause(0.1);
    
end
disp(['Forward Kinematics:'])
disp(robot.model.fkine(robot.model.getpos()));




for i = 1:size(trajectory5, 1)
    robot.model.animate(trajectory5(i, :));
    drawnow;
    pause(0.1);
end
disp(['Forward Kinematics:'])
disp(robot.model.fkine(robot.model.getpos()));

for i = 1:size(trajdrop5, 1)
    robot.model.animate(trajdrop5(i, :));
    drawnow;
    pause(0.1);
    
end
disp(['Forward Kinematics:'])
disp(robot.model.fkine(robot.model.getpos()));





for i = 1:size(trajectory6, 1)
    robot.model.animate(trajectory6(i, :));
    drawnow;
    pause(0.1);
end
disp(['Forward Kinematics:'])
disp(robot.model.fkine(robot.model.getpos()));

for i = 1:size(trajdrop6, 1)
    robot.model.animate(trajdrop6(i, :));
    drawnow;
    pause(0.1);
    
end
disp(['Forward Kinematics:'])
disp(robot.model.fkine(robot.model.getpos()));
% keyboard;