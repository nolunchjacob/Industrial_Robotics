clear all;
clc


hold on;
% to add environment uncomment line below and uncomment the axis
% visualize_and_analyze_robot_test;
% axis([-2, 3, -2, 2, 0, 2]); % Set axis limits to match your robot's workspace


% baseTr = transl([-0.5, 0, 0.5]) * trotx(0) * troty(0) * trotz(0);
baseTr = transl([0, 0, 0]) * trotx(0) * troty(0) * trotz(0);

% Initialise robot
    robot = DobotMagician(baseTr);
    % q = robot.model.getpos();
    % robot.model.fkine(q);


% set different coin positions
    % pos_coin1 = [-0.3, -0.2, 0.5];
pos_coin1 = [0.25, 0, 0];

% call the coin models at the coin positions
    fivecentcoin_pos(pos_coin1);
    

    
% keyboard;


% use ikcon to find desired joint angles for different coin pos
% coin starting pos
q_startpos = robot.model.ikcon(transl(0.2, 0, 0.1));

% rotate 180 degrees about x axis so claw faces down
q1 = robot.model.ikcon(transl(pos_coin1) * trotx(pi));



%drop off position
q_drop = robot.model.ikcon(transl(0.2, 0, 0.2) * trotx(pi));





% robot moves from starting pos->1st coin-> (drop off->next coin (repeat))
trajectory1 = jtraj(q_startpos, q1, 50);
trajdrop1 = jtraj(q1, q_drop, 50);

% Animate the robot's motion along the trajectory

% starting pos->1st coin->drop off
for i = 1:size(trajectory1, 1)
    robot.model.animate(trajectory1(i, :));
    


    drawnow;
    pause(0.1);
    
end
disp(['Pick up 1 Forward Kinematics:'])
disp(robot.model.fkine(robot.model.getpos()));


animateCoinTrajectory(robot, q1, q_drop);
% for i = 1:size(trajdrop1, 1)
%     robot.model.animate(trajdrop1(i, :));
% 
%     drawnow;
%     pause(0.1);
% 
% end

disp(['Drop off Forward Kinematics:'])
disp(robot.model.fkine(robot.model.getpos()));