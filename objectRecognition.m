clear all;
clc


%% reference: https://www.youtube.com/watch?v=lQTCq87DSrc&t=28s

hold on;
% visualize_and_analyze_robot_test;
% axis([-2, 3, -2, 2, 0, 2]); % Set axis limits to match your robot's workspace
% baseTr = transl([-0.5, 0, 0.5]) * trotx(0) * troty(0) * trotz(0);
baseTr = transl([-0.5, 0, 0]) * trotx(0) * troty(0) * trotz(0);
    robot = DobotMagician(baseTr);
    q = robot.model.getpos();
  %  view([0,0.5,0.4])
    robot.model.fkine(q);
% Define position vectors for q1 to q9 (adjust the values as needed)
    pos_coin1 = [-0.3, -0.2, 0]; %% five cent coin
    pos_coin2 = [-0.4, -0.2, 0]; %% ten cent coin
    pos_coin3 = [-0.5, -0.2, 0]; %% twenty cent coin
    pos_coin4 = [-0.3, 0.2, 0]; %% one dollar coin 
    pos_coin5 = [-0.4, 0.2, 0]; %% two dollar coin 
    pos_coin6 = [-0.5, 0.2, 0]; %% one dollar coin 


%% five cent coin dimensions atm 20 x 10 ^-3 
%% ten cent coin 0.2
%% twenty cent coin 0.02 * 10 ^-3  
%% one dollar coin 2 x 10 ^-4 
%% two dollar coin  0.02 * 10 ^-3 


    % % Call brick_pos function with each position vector to place bricks
    fivecentcoin_pos(pos_coin1);
    tencentcoin_pos(pos_coin2);
    twentyCentCoin_pos(pos_coin3);
    oneDollarCoin_pos(pos_coin4);
    twoDollarCoin_pos(pos_coin5);
    oneDollarCoin_pos(pos_coin6);

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


% Define a trajectory of joint configurations
q_startpos = robot.model.ikcon(transl(-0.2, 0, 0.1));
q1 = robot.model.ikcon(transl(pos_coin1) * trotx(pi));
q2 = robot.model.ikcon(transl(pos_coin2) * trotx(pi));
q3 = robot.model.ikcon(transl(pos_coin3) * trotx(pi)); 
q4 = robot.model.ikcon(transl(pos_coin4) * trotx(pi));
q5 = robot.model.ikcon(transl(pos_coin5) * trotx(pi));
q6 = robot.model.ikcon(transl(pos_coin6) * trotx(pi));


%drop off positions
q_drop = robot.model.ikcon(transl(-0.2, 0, 0.1) * trotx(pi));
view([90 50]) %% http://www.ece.northwestern.edu/local-apps/matlabhelp/techdoc/ref/view.html 
% ^^^^setting a custom view of the workspace 


%% https://undocumentedmatlab.com/articles/screencapture-utility

%imageData = screencapture();%% taking a screenshot of the figure/workspace with the custom position/view of the camera
imageData = screencapture(gcf,[20,30,40,40]);
imwrite(imageData, 'calibrationImage.png') %%saving the screenshot 
figure
rgb = imread("calibrationImage.png");
%[J, rect] = imcrop();
targetSize = [420 600];
r = centerCropWindow2d(size(rgb), targetSize);
J = imcrop(rgb,r); %% crops image to remove the title of window etc 
imshow(J) 
%rgbcropped = imcrop(rgb, [])
% 
% rgbcropped = imshow(rgb, [75 68 130 112]); 

% d = drawline; %%% code commented out this line and below lets you draw a
% line to see how long the coins are, good for calibration
% pos = d.Position;
% diffPos = diff(pos);
% diameter = hypot(diffPos(1), diffPos(2));

gray_image = im2gray(J); %%change the cropped image from rgb to grayscale
figure 
imshow(gray_image);

[centers, radii] = imfindcircles(J,[2 6], "ObjectPolarity", "dark", "Sensitivity", 0.89)
h = viscircles(centers,radii); 


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
