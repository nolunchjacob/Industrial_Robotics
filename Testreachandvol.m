%% Reach and Volume
clear all;
clc
 % Create a LinearUR3 robot with a custom base transformation
    baseTr = transl([-0.5, 0, 0]) * trotx(0) * troty(0) * trotz(0);
    robot = DobotMagician(baseTr);

    hold on;

    % Define the workspace and scaling factor
    axis([-2, 2, -2, 2, -2, 2]);
    input('Press enter to continue');

    % Task a) Calculate the maximum reach of the robot
    qlim = robot.model.qlim;
    stepRads = deg2rad(10);
    pointCloudSize = prod(floor((qlim(1:4, 2) - qlim(1:4, 1)) / stepRads + 1));
    pointCloud = zeros(pointCloudSize, 3);
    counter = 1;
    qAll = zeros(pointCloudSize, 4); % Modify to store only the first 4 joint variables

    baseTr = robot.model.base.T;
    for i = 1:robot.model.n
        T_zd = [1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 1, robot.model.links(i).d; 0, 0, 0, 1];
        T_xa = [1, 0, 0, robot.model.links(i).a; 0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1];
        cosAlpha = cos(robot.model.links(i).alpha);
        sinAlpha = sin(robot.model.links(i).alpha);
        T_Rx = [1, 0, 0, 0; 0, cosAlpha, -sinAlpha, 0; 0, sinAlpha, cosAlpha, 0; 0, 0, 0, 1];
        transl_d_x_transl_a_x_trotx_alpha{i} = T_zd * T_xa * T_Rx; %#ok<SAGROW,AGROW>
        thetaOffset(i) = robot.model.links(i).offset; %#ok<SAGROW,AGROW>
    end
    

    tic
    for q1 = qlim(1, 1):stepRads:qlim(1, 2)
        for q2 = qlim(2, 1):stepRads:qlim(2, 2)
            for q3 = qlim(3, 1):stepRads:qlim(3, 2)
                for q4 = qlim(4, 1):stepRads:qlim(4, 2)
                    q = [q1, q2, q3, q4]; % Modify to use only the first 4 joint variables

                    tr = baseTr;
                    for i = 1:4
                        thetaPlusOffset = q(i) + thetaOffset(i);
                        T_Rz = [cos(thetaPlusOffset), -sin(thetaPlusOffset), 0, 0; ...
                            sin(thetaPlusOffset), cos(thetaPlusOffset), 0, 0; ...
                            0, 0, 1, 0; 0, 0, 0, 1;];
                        tr = tr * T_Rz * transl_d_x_transl_a_x_trotx_alpha{i};
                    end
                    
                    q = [q, 0]; %fkine requires 7 columns

                    tr = robot.model.fkine(q).T; %end effector position and orientation

                    q = [q1, q2, q3, q4]; % back to the 4 columns values for q

                    pointCloud(counter, :) = tr(1:3, 4)';
                    qAll(counter, :) = q;

                    counter = counter + 1;

                    if mod(counter / pointCloudSize * 100, 1) == 0
                        disp(['After ', num2str(toc), ' seconds, completed ', num2str(counter / pointCloudSize * 100), '% of poses']);
                    end
                end
            end
        end
    end
    toc

    plot3(pointCloud(:,1),pointCloud(:,2),pointCloud(:,3),'r.');
    
    
%     % Calculate the maximum reach of the robot
% basePosition = baseTr(1:3, 4)'; % Updated base position
% 
% % Calculate distances from the base to each end-effector position
% distances = sqrt(sum((pointCloud - basePosition).^2, 2));
% 
% 
% % Find the maximum distance (maximum reach)
%     maxReach = max(distances);
% 
% 
% % Display the maximum reach
% disp(['Maximum Reach: ', num2str(maxReach), ' meters']);
% 
% 
%     % Task b) Calculate the approximate volume
%     % Calculate the approximate volume of the robot's workspace
%     % Find the minimum and maximum coordinates in each dimension (x, y, z)
%     min_coords = min(pointCloud);
%     max_coords = max(pointCloud);
% 
%     % Calculate the dimensions of the bounding box
%     length_x = max_coords(1) - min_coords(1);
%     width_y = max_coords(2) - min_coords(2);
%     height_z = max_coords(3) - min_coords(3);
% 
%     % Calculate the approximate volume of the bounding box
%     workspace_volume = length_x * width_y * height_z;
% 
%     % Display the approximate volume
%     disp(['Approximate Volume: ', num2str(workspace_volume), ' cubic meters']);
% 
%     keyboard;
clf