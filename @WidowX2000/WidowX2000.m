classdef WidowX2000 < RobotBaseClass

    %% Copy/Paste this folder into PeterCorkes Toolbox 
    %% PLY File locations need to be changed in MESHLAB 
    %% DH Parameters need to be corrected 
    
    %% PLY read error fixed

    properties(Access = public)
        plyFileNameStem = 'WidowX2000';
    end

                   
    methods            
            function self = WidowX2000(baseTr)
              self.CreateModel();
         if nargin < 1
                 baseTr = eye(4);
         end      
            self.CreateModel();
            self.model.base = self.model.base.T * baseTr * trotx(pi/2) * troty(pi/2);
            axis equal
            self.PlotAndColourRobot(); 
            q = zeros(1,6); %% <- don't let link 7 fool you 
            self.model.teach(q)
            drawnow;
        end

    %%CreateModel
        function CreateModel(self)
            
            %% Link 0 PLY file = Link 1 below, 
            %% If done another way it gets the PLY read error
            %% DH PARAMETERS BELOW ARE INCORRECT, but have gotten rid of the PLY read error which is good ! :)
            
            link(1) = Link('d',0,'a',0.11325,'alpha',pi/2,'offset',0,'qlim',[deg2rad(-180),deg2rad(180)]);
            link(2) = Link('d',0.11325,'a',0,'alpha',pi/2,'offset',0,'qlim',deg2rad([-180 180]));
            link(3) = Link('d',0,'a',0.20616,'alpha',0,'offset',0,'qlim',deg2rad([-108 113]));
            link(4) = Link('d',0,'a',0.200,'alpha',0,'offset',0,'qlim',deg2rad([-108 93]));
            link(5) = Link('d',0,'a',0.065,'alpha',0,'offset',0,'qlim',deg2rad([-100 123]));
            link(6) = Link('d',0.10916,'a',0,'alpha',pi/2,'offset',0,'qlim',deg2rad([-180 180]));
            link(7) = Link('d',0,'a',0,'alpha',0,'offset',0,'qlim',deg2rad([-180 180]));
        
            self.model = SerialLink([link(1) link(2) link(3) link(4) link(5) link(6)],'name',self.name);
  
        end
    end
end








    























    %% If we want to do control methods 
    % Jm = Inertia of motor
    % Bm = Friction of motor 
    % Km = Motor Torque Constant 
    % Kd = Amplifier Gain
    % G = Gear Ratio 
