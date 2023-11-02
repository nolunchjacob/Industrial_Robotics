function animateCoinTrajectory(robot, pos_coin, q_drop)
    % [f, v, data] = plyread('fiveCentCoin.ply', 'tri');
    [f, v, data] = plyread('HalfSizedRedGreenBrick.ply', 'tri');
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Create a figure for visualization
    % figure;
    hold on;

    % Create a joint-space trajectory from pos_coin1 to q_drop
    numSteps = 50;  % Number of steps for the trajectory
    jtraj_steps = jtraj(pos_coin, q_drop, numSteps);

    % Loop through each joint configuration in the trajectory
    for i = 1:numSteps
        q = jtraj_steps(i, :);

        % Use the forward kinematics to get the end-effector position
        trmatrix = robot.model.fkine(q).T;
        % pos_vector = trmatrix(1:3, 4)';
        
        
        v_trmatrix = (trmatrix(1:3, 1:3) * v' + trmatrix(1:3, 4))';

        % Plot the coin at the end-effector position
        coinMesh_h = trisurf(f, v_trmatrix(:, 1), v_trmatrix(:, 2), v_trmatrix(:, 3), ...
            'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');

        % Configure the view, axis limits, and other settings as needed
        view(3);
        grid on;

        robot.model.animate(q)
        drawnow;  % Update the plot

        % Pause for a short duration to create an animation effect
        pause(0.1);  % You can adjust the duration

        % Clear the previous coin position for the next frame
        if exist('coinMesh_h', 'var')
            delete(coinMesh_h);
        end
        
    end
    
end
