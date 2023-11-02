function environmentTest()
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
    axis([-3, 3, -3, 3, 0, 2]); % Set axis limits to match your robot's workspace


    %      scenario = robotScenario(UpdateRate=10);
    % addMesh(scenario,"Plane",Position=[0 0 0],Size=[4 4],Color=[0.7 0.7 0.7]);
    % show3D(scenario)

    floor_size = 6;
floor = patch([-floor_size, floor_size, floor_size, -floor_size], -floor_size, -floor_size, floor_size, floor_size], [0.1, 0.1, 0.1, 0.1]);


    



    %% emergency stop button 
   plyfilename1 = 'emergencyStopWallMounted.ply';
   transformationMatrix1 = transl([2, 2, 1]) * trotx(0) * troty(0) * trotz(pi);
   modelObject(plyfilename1,transformationMatrix1);

%% table

%Error using fread
%Invalid precision.
   % plyfilename2 = 'tableBrown2.1x1.4x0.5m.ply';
   % transformationMatrix2 = transl([0, 0, 0.5]) * trotx(0) * troty(0) * trotz(pi);
   % modelObject(plyfilename2,transformationMatrix2);
  
%% fire extinguisher
    plyfilename3 = 'fireExtinguisher.ply';
    transformationMatrix3 = transl([2.5, 1.9, 0.5]) * trotx(0) * troty(0) * trotz(pi/2);
    modelObject(plyfilename3,transformationMatrix3);

%% Lab Supervosr
    plyfilename4 = 'labsupervisor.ply';
    transformationMatrix4 = transl([2.5, 0, 0]) * trotx(0) * troty(0) * trotz(pi);
    modelObject(plyfilename4,transformationMatrix4);

% %% barrier
%     plyfilename5 = 'barrier.ply';
%     transformationMatrix5 = transl([1.5, 0, 0]) * trotx(0) * troty(0) * trotz(0);
%     modelObject(plyfilename5,transformationMatrix5);

% 
% %% long barrier
%     plyfilename6 = 'longbarrier.ply';
%     transformationMatrix6 = transl([-0.3, -1, 0]) * trotx(0) * troty(0) * trotz(-pi/2);
%     modelObject(plyfilename6,transformationMatrix6);

%         %% bookcase
% plyfilename8 = 'bookcaseTwoShelves0.5x0.2x0.5m.ply';
% transformationMatrix8 = transl([-0.3, 1.7, 0]) * trotx(0) * troty(0) * trotz(0);
% modelObject(plyfilename8,transformationMatrix8);

%             %% chair
% plyfilename9= 'chair.ply';
% transformationMatrix9 = transl([2.5, -1.5, 0]) * trotx(pi/2) * troty(-pi/2) * trotz(0);
% modelObject(plyfilename9,transformationMatrix9);
% 

    %% PERSON
plyfilename10 = 'personMaleCasual.ply';
transformationMatrix10 = transl([1, -1.7, 0]) * trotx(0) * troty(0) * trotz((3*pi)/4);
modelObject(plyfilename10,transformationMatrix10);

plyfilename11 = 'tableNewNew2.ply';
transformationMatrix11 = transl([2, -1.5, 0]) * trotx(0) * troty(0) * trotz((3*pi)/4);
modelObject(plyfilename11,transformationMatrix11);

% plyfilename12 = 'five_cent_box_ply.ply';
% transformationMatrix12 = ;
% modelObject(plyfilename12,transformationMatrix12);
% 
% plyfilename13 = 'ten_cent_box_ply.ply';
% transformationMatrix13 = ;
% modelObject(plyfilename13,transformationMatrix13);
% 
% plyfilename14 = "twenty_cent_coin_box_ply.ply";
% transformationMatrix14 = ;
% modelObject(plyfilename14,transformationMatrix14);
% 
% plyfilename14 = "one_dollar_coin_box_ply.ply";
% transformationMatrix14 = ;
% modelObject(plyfilename14,transformationMatrix14);
% 
% plyfilename14 = "two_dollar_coin_box.ply";
% transformationMatrix14 = ;
% modelObject(plyfilename14,transformationMatrix14);
% 



    function modelObject(plyfilename, transformationMatrix)
            [f, v, data] = plyread(plyfilename, 'tri');
            vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
            v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';
            trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');        
    end
end






