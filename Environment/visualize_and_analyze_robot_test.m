function visualize_and_analyze_robot_test()
    close all;
    clc;

     % Create a figure for visualization
    figure;
    hold on;
    title('3D Model Visualization');
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    view(3);
    axis([-2, 3, -2, 2, 0, 2]); % Set axis limits to match your robot's workspace

    %% emergency stop button
    % Load the desk model data
    [f, v, data] = plyread('emergencyStopWallMounted.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([2, 2, 1]) * trotx(0) * troty(0) * trotz(pi);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');

%% table
        % Load the desk model data
    [f, v, data] = plyread('tableBrown2.1x1.4x0.5m.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([0, 0, 0]) * trotx(0) * troty(0) * trotz(0);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');


%% fire extinguisher
            % Load the desk model data
    [f, v, data] = plyread('fireExtinguisher.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([2.5, 1.9, 0.5]) * trotx(0) * troty(0) * trotz(pi/2);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');


    %% Person
            % Load the desk model data
    [f, v, data] = plyread('labsupervisor.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([2.5, 0, 0]) * trotx(0) * troty(0) * trotz(pi);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');

    %% barrier
        % Load the desk model data
    [f, v, data] = plyread('barrier.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([1.5, 0, 0]) * trotx(0) * troty(0) * trotz(0);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');


        %% long barrier
        % Load the desk model data
    [f, v, data] = plyread('longbarrier.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([-0.3, -1, 0]) * trotx(0) * troty(0) * trotz(-pi/2);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');



end






