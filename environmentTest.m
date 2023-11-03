function environmentTest()
    close all;
    clc;

     % Create a figure for visualization

        
    figure;
    hold on;
    title('3D Model Visualization');
    %camlight 
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    view(3);
    axis([-3, 3, -3, 3, 0, 2]); % Set axis limits to match your robot's workspace
    wall1 = patch([-3, 3, 3, -3], [3, 3, 3, 3],[0, 0, 3, 3],[0.5, 0.5, 0.5]);
    wall2 = patch([3, 3, 3, 3], [-3, 3, 3, -3],[0, 0, 3, 3],[0.5, 0.5, 0.5]);


    floor = patch([-3, 3, 3, -3], [-3, -3, 3, 3], [0.7, 0.7, 0.7]);
   
    cautionLine = patch([-2, 1.5, 1.5, -2], [1, 1, 3, 3],[0.01, 0.0099, 0.0099, 0.0099], [1, 1, 0]);
    cautionLine2 = patch([-1.8, 1.3, 1.3, -1.8], [1.2, 1.2, 3, 3],[0.01, 0.01, 0.01, 0.01],[0.7, 0.7, 0.7]);
    
    

    %      scenario = robotScenario(UpdateRate=10);
    % addMesh(scenario,"Plane",Position=[0 0 0],Size=[4 4],Color=[0.7 0.7 0.7]);
    % show3D(scenario)

  

%EdgeColor;

    



    %% emergency stop button 
   plyfilename1 = 'emergencyStopWallMounted.ply';
   transformationMatrix1 = transl([2, 2, 1]) * trotx(0) * troty(0) * trotz(0);
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

%     %% PERSON
% plyfilename10 = 'personMaleCasual.ply';
% transformationMatrix10 = transl([1, -1.7, 0]) * trotx(0) * troty(0) * trotz((3*pi)/4);
% modelObject(plyfilename10,transformationMatrix10);
% 


% 
% PlaceObject('tablenewnew.ply',[-1, 1, 0]);

% PlaceObject('tableNewNew_part1.ply')


% 
% plyfilename11 = 'tableNewNew_part1.ply';
% transformationMatrix11 = transl([2, 2, 0]) * trotx(0) * troty(0) * trotz((3*pi)/4);
% modelObject(plyfilename11,transformationMatrix11);
% 
% 
% plyfilename12 = 'tableNewNew_part2.ply';
% transformationMatrix12 = transl([2, 2, 0]) * trotx(0) * troty(0) * trotz((3*pi)/4);
% modelObject(plyfilename12,transformationMatrix12);
% 
% 
% plyfilename13 = 'tableNewNew_part3.ply';
% transformationMatrix13 = transl([2, 2, 0]) * trotx(0) * troty(0) * trotz((3*pi)/4);
% modelObject(plyfilename13,transformationMatrix13);
% 
% 
% plyfilename14 = 'tableNewNew_part4.ply';
% transformationMatrix14 = transl([2, 2, 0]) * trotx(0) * troty(0) * trotz((3*pi)/4);
% modelObject(plyfilename14,transformationMatrix14);
% 
% plyfilename14 = 'tableNewNew_part4.ply';
% transformationMatrix14 = transl([2, 2, 0]) * trotx(0) * troty(0) * trotz((3*pi)/4);
% placeObject(plyfilename14,transformationMatrix14);
% 
% 
% placeObject 

% 
plyfilename15 = 'tableWorkspace.ply';
transformationMatrix15 = transl([1, 1.68, 0]) * trotx(0) * troty(0) * trotz(pi);
modelObject(plyfilename15,transformationMatrix15);

% figure 


plyfilename11 = 'painted5cbox.ply';
transformationMatrix11 = transl([-1, 2.15, 1.02]) * trotx(0) * troty(0) * trotz(pi/2);
modelObject(plyfilename11,transformationMatrix11);

plyfilename12 = 'painted_ten_cent_coin_box.ply';
transformationMatrix12 = transl([-1, 2.30, 1.02]) * trotx(0) * troty(0) * trotz(pi/2); 
modelObject(plyfilename12,transformationMatrix12);

% plyfilename13 = 'paintedten_cent_box_ply.ply';
% transformationMatrix13 = ;
% modelObject(plyfilename13,transformationMatrix13);
% 
plyfilename14 = "painted_twenty_cent_coin_box.ply";
transformationMatrix14 = transl([-0.80, 2.57, 1.02]) * trotx(0) * troty(0) * trotz(pi/2);
modelObject(plyfilename14,transformationMatrix14);
% 
plyfilename15 = "painted_one_dollar_coin_box.ply";
transformationMatrix15 = transl([0.2, 2.2, 1.01]) * trotx(0) * troty(0) * trotz(0);
modelObject(plyfilename15,transformationMatrix15);
% 
plyfilename16 = "painted_two_dollar_coin_box.ply";
transformationMatrix16 = transl([0.2, 2.35, 1.01]) * trotx(0) * troty(0) * trotz(pi/2);
modelObject(plyfilename16,transformationMatrix16);


%lighting edgelighting
%lighting gouraud 
%FaceLighting 
    function modelObject(plyfilename, transformationMatrix)
            [f, v, data] = plyread(plyfilename, 'tri'); %, ReadColor,'true'
            vertexColours = [data.vertex.red, data.vertex.green, data.vertex.blue] / 255;
            v_transformed = (transformationMatrix(1:3, 1:3) * v' + transformationMatrix(1:3, 4))';
            trisurf(f, v_transformed(:, 1), v_transformed(:, 2), v_transformed(:, 3), ...
        'FaceVertexCData', vertexColours, 'EdgeColor', 'interp', 'EdgeLighting', 'flat');        
    end
end






