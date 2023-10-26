clear all;
clc


%% reference: https://www.youtube.com/watch?v=lQTCq87DSrc&t=28s
%% Eye 2 hand configuration
hold on;
% visualize_and_analyze_robot_test;
% axis([-2, 3, -2, 2, 0, 2]); % Set axis limits to match your robot's workspace
% baseTr = transl([-0.5, 0, 0.5]) * trotx(0) * troty(0) * trotz(0);

  %  view([0,0.5,0.4])
   
% Define position vectors for q1 to q9 (adjust the values as needed)
    





% % % % 
% % % %     pStar = [662 362 362 662; 362 362 662 662];
% % % %     P=[1.8,1.8,1.8,1.8;
% % % % -0.25,0.25,0.25,-0.25;
% % % %  1.25,1.25,0.75,0.75];
% % % %     cam = CentralCamera('focal', 0.08, 'pixel', 10e-5, ...
% % % % 'resolution', [1024 1024], 'centre', [512 512],'name', 'UR10camera');
% % % %     fps = 25;
% % % %     lambda = 0.6;
% % % %     depth = mean (P(1,:));
% % % %     cam.project(P);
% % % %     cam.plot_camera('label', 'scale', 0.15);
% % % %     plot_sphere(P, 0.05, 'b')
% % % % lighting gouraud
% % % % light
% % % % 
% % % % gridOfSpheres = [0;0;5]; 
% % % % 
% % % % self.UpdateCameraAndView( transl(0,0,1) * troty(0.1) )
% % % % plot_sphere(self.gridOfSpheres, 0.05, 'b')
% % % % grid on
% % % % self.AddCameraControls();

%% five cent coin dimensions atm 20 x 10 ^-3 
%% ten cent coin 0.2
%% twenty cent coin 0.02 * 10 ^-3  
%% one dollar coin 2 x 10 ^-4 
%% two dollar coin  0.02 * 10 ^-3 


    % % Call brick_pos function with each position vector to place bricks

% % keyboard;
% P = [-0.2, 0, 0.8]; 
% 
% cam = CentralCamera('focal', 0.08, 'pixel', 10e-5, ...
% 'resolution', [1024 1024], 'centre', [512 512],'name', 'camera');
% 
% % frame rate
% fps = 25;
% 
% cam.plot(P);


%camera_pos = 90.1972,35.5351
%projection = orthagraphic




hold on

environment;
camera = objectRecogClass();

camera.camera_h
camera.UpdateCameraAndView(environment)
camera.AddCameraControls()


view([90 50]) %% http://www.ece.northwestern.edu/local-apps/matlabhelp/techdoc/ref/view.html 
% ^^^^setting a custom view of the workspace 

% Define a trajectory of joint configurations



%drop off positions



%% https://undocumentedmatlab.com/articles/screencapture-utility

%imageData = screencapture();%% taking a screenshot of the figure/workspace with the custom position/view of the camera
% imageData = screencapture(gcf,[20,30,40,40]);
% imwrite(imageData, 'calibrationImage.png') %%saving the screenshot 
% figure
% rgb = imread("calibrationImage.png");
% %[J, rect] = imcrop();
% targetSize = [420 600];
% r = centerCropWindow2d(size(rgb), targetSize);
% J = imcrop(rgb,r); %% crops image to remove the title of window etc 
% imshow(J) 
% 



% 
% 
% %cam.clf()
% % Create image target (points in the image plane)
% pStar = [662 362 362 662; 362 362 662 662];
% %Create 3D points
% P=[1.8,1.8,1.8,1.8;-0.25,0.25,0.25,-0.25; 1.25,1.25,0.75,0.75];
% % cam = CentralCamera('focal', 0.015, 'pixel', 10e-6, 'rosolution', [1024 1024], 'centre', [512 512], ...
% %      'name', 'cam');
% cam = CentralCamera('focal', 0.015, 'pixel', 10e-6,'rosolution', [1024 1024], 'centre', [512 512], ...
%      'name', 'cam');
% 
% fps = 25;
% gridOfSpheres = mkgrid(2,0.5,'pose',transl(-0.5,0,0));
% 
% 
% %cam.clf()
% cam.T = transl(-0.5,0,1.5) * troty(pi);
% hold on
% 
% plot_sphere(gridOfSpheres, 0.02, 'b')
% grid on
% 
% %cam.plot(pStar, '*');
% %cam.plot(gridOfSpheres, 'o', pStar, '*');
% 
% %cam.plot(gridOfSpheres, 'o')
% cam.plot_camera
% cam.project(gridOfSpheres)
% drawnow
% cam.hold(true)
% hold on
% cam.plot(P)
% % img = snapshot(cam);
% % imshow(img)
% lighting gouraud
% light
% AddCameraControls();
% 
% figure()
% 









%rgbcropped = imcrop(rgb, [])
% 
% rgbcropped = imshow(rgb, [75 68 130 112]); 

% d = drawline; %%% code commented out this line and below lets you draw a
% line to see how long the coins are, good for calibration
% pos = d.Position;
% diffPos = diff(pos);
% diameter = hypot(diffPos(1), diffPos(2));

% gray_image = im2gray(J); %%change the cropped image from rgb to grayscale
% figure 
% imshow(gray_image);
% 
% [centers, radii] = imfindcircles(J,[2 6], "ObjectPolarity", "dark", "Sensitivity", 0.89, "EdgeThreshold",0.1)
% h = viscircles(centers,radii); 






% 
% 
% function uv = UpdateCameraAndView(self,tr)
% if 1 < nargin
% cam.T = tr;
% end
% % Update where the camera is plotted
% cam.plot_camera(self.gridOfSpheres, 'label', 'scale', 0.15);
% % Update what the camera sees
% uv = cam.plot(gridOfSpheres, 'o');
% for i = 1:size(uv,2)
% self.text_h(i) = text(uv(1,i), uv(2,i), sprintf('%d', i), 'Color', 'red', 'FontSize', 12,'Parent',gca(cam.figure));
% end
% drawnow
% end
% 
% 





% 
% %% AddCameraControls
% function AddCameraControls(self)
% sliderProperties = struct('Style', 'slider', 'Value', 0, 'SliderStep', [0.01 0.2], 'Callback', @self.SliderCallback);
% uicontrol(sliderProperties , 'Position', [0 60 200 10], 'String', 'sliderX' , 'Min', -1 , 'Max', 3);
% uicontrol(sliderProperties , 'Position', [0 50 200 10], 'String', 'sliderY' , 'Min', -1 , 'Max', 3);
% uicontrol(sliderProperties , 'Position', [0 40 200 10], 'String','sliderZ' , 'Min', -1 , 'Max', 3); 
% uicontrol(sliderProperties, 'Position', [0 20 200 10], 'String','sliderRotY','Min', -pi/4,'Max', pi/4);
% uicontrol('Style','pushbutton','String','Set Target','Position', [0 20 100 20],'Parent',cam.figure,'Callback',@self.TargetUserSelectedPointsWithImagejacobian);
% end
% 
% %% SliderCallback
% function SliderCallback(self,source, ~)
% sliderValue = get(source, 'Value');
% tr = self.cam.T.T;
% switch source.String
% case 'sliderX'
% tr(1,4) = sliderValue;
% case 'sliderY'
% tr(2,4) = sliderValue;
% case 'sliderZ'
% tr(3,4) = sliderValue;
% case 'sliderRotY'
% tr(1:3,1:3) = roty(sliderValue);
% end
% self.UpdateCameraAndView(tr);
% end


function environment
    baseTr = transl([-0.5, 0, 0]) * trotx(0) * troty(0) * trotz(0);
    robot = DobotMagician(baseTr);
    q = robot.model.getpos();
    robot.model.fkine(q);
    pos_coin1 = [-0.3, -0.2, 0]; %% five cent coin
    pos_coin2 = [-0.4, -0.2, 0]; %% ten cent coin
    pos_coin3 = [-0.5, -0.2, 0]; %% twenty cent coin
    pos_coin4 = [-0.3, 0.2, 0]; %% one dollar coin 
    pos_coin5 = [-0.4, 0.2, 0]; %% two dollar coin 
    pos_coin6 = [-0.5, 0.2, 0]; %% one dollar coin 
    fivecentcoin_pos(pos_coin1);
    tencentcoin_pos(pos_coin2);
    twentyCentCoin_pos(pos_coin3);
    oneDollarCoin_pos(pos_coin4);
    twoDollarCoin_pos(pos_coin5);
    oneDollarCoin_pos(pos_coin6);
    q_startpos = robot.model.ikcon(transl(-0.2, 0, 0.1));
    q1 = robot.model.ikcon(transl(pos_coin1) * trotx(pi));
    q2 = robot.model.ikcon(transl(pos_coin2) * trotx(pi));
    q3 = robot.model.ikcon(transl(pos_coin3) * trotx(pi)); 
    q4 = robot.model.ikcon(transl(pos_coin4) * trotx(pi));
    q5 = robot.model.ikcon(transl(pos_coin5) * trotx(pi));
    q6 = robot.model.ikcon(transl(pos_coin6) * trotx(pi));
    q_drop = robot.model.ikcon(transl(-0.2, 0, 0.1) * trotx(pi));

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

end 



