function RMRCDLStest()
    close all;
    clc
    % Create a 3D robot model
    mdl_puma560; % You can replace 'puma560' with the robot model you intend to use
    minManipMeasure = 0.1;

    %if you change these values you have to change x1 and x2
    % Define the initial and final poses in 3D space
    T1 = transl(0, 0.27, 0); % Define the initial pose

    % the values below create a singularity (0.45, 0.2, 0.3 these don't)
    T2 = transl(0.5, 0.5, 0.5); % Define the final pose 


    % Define a masking matrix for the IK solver
    % M = [1 1 1 0 0 0]; % Considering all three positions, ignoring orientation

    % Solve for joint angles using inverse kinematics
    % q1 = p560.ikine(T1, 'mask', M);
    % q2 = p560.ikine(T2, 'mask', M);
    q1 = p560.ikcon(T1);
    q2 = p560.ikcon(T2);

    % Define the number of steps for interpolation
    steps = 50;

    % Joint Interpolation
    qMatrix = jtraj(q1, q2, steps);
    p560.plot(qMatrix, 'trail', 'r-'); % Plot the joint interpolation

    % Resolved Motion Rate Control (RMRC)
    deltaT = 0.1; % Discrete time step

    % Define initial and final positions in 3D space
    x1 = [0; 0.27; 0];
    x2 = [0.5; 0.5; 0.5];

    % Create a trajectory in 3D space
    x = zeros(3, steps);
    for i = 1:steps
        x(:, i) = x1 + (x2 - x1) * (i - 1) / (steps - 1);
    end


    qMatrix = nan(steps, 6);

    % Solve for joint angles using inverse kinematics for the initial position
    % qMatrix(1, :) = p560.ikine(T1, 'mask', M);
    qMatrix(1, :) = p560.ikcon(T1);

    % for i = 1:steps - 1
    %     % Calculate the velocity in 3D space
    %     xdot = (x(:, i + 1) - x(:, i)) / deltaT;
    % 
    %     % Calculate Jacobian and perform RMRC for the next joint state
    %     J = p560.jacob0(qMatrix(i, :));
    %     J = J(1:3, :); % Consider only the position part of the Jacobian
    %     qdot = pinv(J) * xdot;
    %     qMatrix(i + 1, :) = qMatrix(i, :) + deltaT * qdot';
    % end

    % my attempt at dealing with singularities
    % if you want to have a go comment out for loop above

startPose = true;
if startPose
    m = zeros(1, steps);
    error = zeros(3, steps); 

    lambda = 0.01; % Damping factor for DLS

    for i = 1:steps - 1
        xdot = (x(:, i + 1) - x(:, i)) / deltaT;
        J = p560.jacob0(qMatrix(i, :));
        Jv = J(1:3, :);
        m(i) = sqrt(det(Jv * Jv'));

        if m(i) < minManipMeasure
            % Damped Least Squares method
            J_dls = Jv' / (Jv * Jv' + lambda * eye(3));
            qdot = J_dls * xdot;
        else
            qdot = pinv(Jv) * xdot;
        end

        error(:, i) = xdot - Jv * qdot; 
        qMatrix(i + 1, :) = qMatrix(i, :) + deltaT * qdot';
    end

    % Plot the RMRC trajectory
    % p560.plot(qMatrix, 'trail', 'r-');
end


        figure(1)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    p560.plot(qMatrix,'trail','r-')                                               % Animate the robot
    figure(2)
    plot(m,'k','LineWidth',1);                                                  % Plot the Manipulability
    title('Manipulability of Puma560')
    ylabel('Manipulability')
    xlabel('Step')
    figure(3)
    plot(error','Linewidth',1)
    ylabel('Error (m/s)')
    xlabel('Step')
    legend('x-velocity','y-velocity');
end
