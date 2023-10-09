classdef WidowX200 < RobotBaseClass


    properties(Access = public)
        plyFileNameStem = 'WidowX200';
    end

    %% Constructor
                     %methods(Access = public)   
    methods    
                    % function self = WidowX200(baseTr,useTool,toolFilename)
                    %  if nargin < 2
                    %     if nargin == 0
                    %          baseTr = transl(0,0,0);  
                    %     end
                    % else 
                    %         self.useTool = useTool;
                    %         toolTrData = load([toolFilename,'.mat']);
                    %         self.toolTr = toolTrData.tool;
                    %         self.toolFilename = [toolFilename,'.ply'];
                    %  end   
                    % 
                    %     self.CreateModel();
                    %     self.model.base = self.model.base.T * baseTr;
                    %     self.model.tool = self.toolTr;
                    %     self.PlotAndColourRobot();  
                    %    % axis equal
                    %     drawnow
                    % end
          function self = WidowX200(baseTr,useTool,toolFilename)
         if nargin < 2
            if nargin == 0
                 baseTr = transl(0,0,0);  
            end
        else 
                self.useTool = useTool;
                toolTrData = load([toolFilename,'.mat']);
                self.toolTr = toolTrData.tool;
                self.toolFilename = [toolFilename,'.ply'];
         end   

            self.CreateModel();
            self.model.base = self.model.base.T * baseTr;
            self.model.tool = self.toolTr;
            self.PlotAndColourRobot();  
           % axis equal
            drawnow
        end

    %%CreateModel
    %% This is most likely not 100% accurate, I am just trying to model it to see
        function CreateModel(self)
               %%gave me an error if the first link was
               %%link(0) instead of link(1)
            %
           % link(0) = Link('d',0.11325,'a',0,'alpha',pi/2,'offset',0,'qlim',[deg2rad(-180),deg2rad(180)]);
            link(1) = Link('d',0.11325,'a',0,'alpha',1.570795,'offset',0,'qlim',deg2rad([-180 180]));
            link(2) = Link('d',0,'a',0.20616,'alpha',0,'offset',0,'qlim',deg2rad([-108 113]));
            link(3) = Link('d',0,'a',0.200,'alpha',0,'offset',0,'qlim',deg2rad([-108 93]));
            link(4) = Link('d',0,'a',0.065,'alpha',0,'offset',0,'qlim',deg2rad([-100 123]));
            link(5) = Link('d',0.10916,'a',0,'alpha',pi/2,'offset',0,'qlim',deg2rad([-180 180]));
            %link(6) = Link('d',0,'a',0,'alpha',0,'offset',0,'qlim',deg2rad([-180 180]));
            self.model = SerialLink(link,'name',self.name);
        end
    end
end








    























    %% If we want to do control methods 
    % Jm = Inertia of motor
    % Bm = Friction of motor 
    % Km = Motor Torque Constant 
    % Kd = Amplifier Gain
    % G = Gear Ratio 
