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
    axis([-2, 3, -2, 2, -0.1, 2]); % Set axis limits to match your robot's workspace

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


    %% bookcase
    % Load the desk model data
    [f, v, data] = plyread('bookcaseTwoShelves0.5x0.2x0.5m.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([-0.3, 1.65, 0]) * trotx(0) * troty(0) * trotz(0);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');

    %% chair
    % Load the desk model data
    [f, v, data] = plyread('chair.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([2.5, -1.5, 0]) * trotx(pi/2) * troty(-pi/2) * trotz(0);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');

    %% Person
    % Load the desk model data
    [f, v, data] = plyread('personMaleCasual.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([1, -1.7, 0]) * trotx(0) * troty(0) * trotz((3*pi)/4);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');

    %% Camera
    % Load the desk model data
    [f, v, data] = plyread('Camera.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([-1.8, 1.8, 2]) * trotx(pi) * troty(0) * trotz(0);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');
    

    %% RMK3 robot
    % Load the desk model data
    [f, v, data] = plyread('RMK3.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([0, 1.8, 0.762]) * trotx(0) * troty(0) * trotz(0);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');

    %% Robot
    % Load the desk model data
    [f, v, data] = plyread('Robot.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([-0.6, 1.8, 0.762]) * trotx(0) * troty(0) * trotz(-pi/4);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');

    %% Floor
    % Load the desk model data
    [f, v, data] = plyread('floor.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([-2, 0, 0]) * trotx(0) * troty(pi/2) * trotz(0);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');

    %% Wall infront of chair
    % Load the desk model data
    [f, v, data] = plyread('floor.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([2.9, 0, -0.1]) * trotx(0) * troty(0) * trotz(0);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');

    %% Wall in front of bookcase
    % Load the desk model data
    [f, v, data] = plyread('floor.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([0.5, 1.9, -0.1]) * trotx(0) * troty(0) * trotz(pi/2);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');

    %% red Container
    % Load the desk model data
    [f, v, data] = plyread('redContainer.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([0.5, 0.2, 0.5]) * trotx(pi) * troty(pi) * trotz(-pi/2);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');

    %% blue Container
    % Load the desk model data
    [f, v, data] = plyread('blueContainer.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Define your transformation matrix for the desk
    transformationMatrix = transl([0.5, -0.2, 0.5]) * trotx(pi) * troty(pi) * trotz(-pi/2);

    % Apply the transformation to the vertex coordinates
    v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';

    % Then plot the trisurf with the transformed vertices for the desk
    trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');
end





