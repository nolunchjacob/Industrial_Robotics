function tencentcoin_pos(pos_vector)
    [f, v, data] = plyread('tenCentCoin.ply', 'tri');

    % Scale the colors to be 0-to-1 (they are originally 0-to-255)
    vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;

    % Create a 4x4 homogeneous transformation matrix from the provided position vector
    trmatrix = transl(pos_vector); % You can modify the rotation as needed

    v_trmatrix = (trmatrix(1:3, 1:3) * v' + trmatrix(1:3, 4))';

    % Create a figure for visualization
    hold on;

    % Plot the brick at the specified position
    brickMesh_h = trisurf(f, v_trmatrix(:, 1), v_trmatrix(:, 2), v_trmatrix(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');

    % Configure the view, axis limits, and other settings as needed
    view(3);
    grid on;

    % Wait for user input (you can remove this if not needed)
    % keyboard;
end