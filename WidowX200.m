classdef WidowX200 < RobotBaseClass


    properties(Access = public)
        plyFileNameStem = "WidowX200"
    end

    % Constructor
    methods(Access = public)
        function self = WidowX200(baseTr)
            self.CreateModel();
            if nargin == 1
                self.model.base = self.model.base.T * baseTr;
            end
            self.PlotAndColourRobot();          
        end

    %CreateModel
        function CreateModel(self)
            link(1) = Link('alpha',-pi/2,'a',0,'d',113.25,'offset',,'qlim',[deg2rad(-180),deg2rad(180)]);
            link(2) = Link('alpha',,'a',,'d',,'offset',,'qlim',[deg2rad(-108),deg2rad(113)]);
            link(3) = Link('alpha',,'a',,'d',,'offset',,'qlim',[deg2rad(-108),deg2rad(93)]);
            Link(4) = Link('alpha',,'a',,'d',,'offset',,'qlim',[deg2rad(-100),deg2rad(123)]);
            Link(5) = Link('alpha',,'a',,'d',,'offset',,'qlim',[deg2rad(-180),deg2rad(180)]);
            self.model = SerialLink(link,'name',self.name)
        end
    end
end








    























    %% If we want to do control methods 
    % Jm = Inertia of motor
    % Bm = Friction of motor 
    % Km = Motor Torque Constant 
    % Kd = Amplifier Gain
    % G = Gear Ratio 
