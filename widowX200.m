%% WidowX200 %% 
  % Below are specifications for the WidowX - 200 
    % https://docs.trossenrobotics.com/interbotix_xsarms_docs/specifications/wx200.html
    % https://docs.trossenrobotics.com/interbotix_xsarms_docs/specifications.html

    % DOF = 5 
    % Total Span = 1100 mm
    % Recommended workspace = 770mm 
    % Working Payload = 200g 

    %% Offsets and True Upper Arm Length 
    % This one is difficult, there is an offset, check out the page for
    % more specifications ? 
    % Joint A -> B = 


    % Gripper:
    % Minimum grip = 30 mm %% <- this is when the gripper is fully closed 
    % Maximum grip = 74 mm
    

   % ETS FORM - FOR THE WIDOWX 250, FROM PETER CORKE 
   % Rz(q1)Tz(L1)Ry(q2)Tz(L2)Tx(L3)Ry(q3)Tx(L4)Rx(q4)Tx(L5)Ry(q5)Tx(L6)Rx(q6)Tx(L7)

    %ETS FORM - WIDOWX 200, not including the offset caused by the 'dog leg' join (L3) 
    %Rz(q1)Tz(L1)Ry(q2)Tz(L2)Tx(L3)Ry(q3)Tx(L4)Ry(q4)Tx(L5)Rx(q5)Tx(L6)

    %% Offset angle = 14.036*, says it is 14* on website but I calculated it
    % a = 50mm
    % b = 200mm
    % c = 206.16mm
    %% OffsetAngleA = arccos((200^2 + 206.16^2 - 50^2)/(2*200*206.16))


    %% For reference - https://petercorke.com/robotics/interbotix-widowx-250-6dof-desktop-robot/?fbclid=IwAR110NtsZHdgEnPg3FZ8ygWlj2_xHuSn_WifEuZnCJW2fMWhW-XEA3MKEWM
    %% Peter Corke Widow250x Original  = Rz(q1)Tz(L1)  Ry(q2) Tz(L2)Tx(L3)               Ry(q3)Tx(L4)Rx(q4)Tx(L5)Ry(q5)Tx(L6)Rx(q6)Tx(L7)
    %% Peter Corke Widow250x w/ Offset = Rz(q1)Tz(L1)  Ry(q2) Ry(beta)Tz(L8)Ry(-beta)    Ry(q3)Tx(L4)Rx(q4)Tx(L5)Ry(q5)Tx(L6)Rx(q6)Tx(L7)

    %% My Original Widow200x  =  Rz(q1)Tz(L1)  Ry(q2)Tz(L2)Tx(L3)                Ry(q3)Tx(L4)Ry(q4)Tx(L5)Rx(q5)Tx(L6)
    %% My Widow200x w/ offset =  Rz(q1)Tz(L1)  Ry(OffsetAngleA)Tz(L8)Ry(-OffsetAngleA)           Ry(q3)Tx(L4)Ry(q4)Tx(L5)Rx(q5)Tx(L6)


   Rz(q1)Tz(L1)Ry(OffsetAngleA)Tz(L8)Ry(-OffsetAngleA)Ry(q3)Tx(L4)Ry(q4)Tx(L5)Rx(q5)Tx(L6)







    %% If we want to do control methods 
    % Jm = Inertia of motor
    % Bm = Friction of motor 
    % Km = Motor Torque Constant 
    % Kd = Amplifier Gain
    % G = Gear Ratio 
