classdef RobotCoins < handle
    %ROBOTCOWS A class that creates a herd of robot cows
	%   The cows can be moved around randomly. It is then possible to query
    %   the current location (base) of the cows.    
    
    %#ok<*TRYNC>    

    properties (Constant)
        %> Max height is for plotting of the workspace
        maxHeight = 4;
    end
    
    properties
        %> Number of cows
        coinCount = 2;
        
        %> A cell structure of \c cowCount cow models
        coinModel;
        
        %> paddockSize in meters
        workspaceSize = [2,2];        
        
        %> Dimensions of the workspace in regard to the padoc size
        workspaceDimensions;
    end
    
    methods
        %% ...structors
        function self = RobotCoins(coinCount, basePose) % Added basePose to allow for exact placement of each brick.
            if 0 < nargin
                self.coinCount = coinCount;
            end
            
            self.workspaceDimensions = [-self.workspaceSize (1)/2, self.workspaceSize (1)/2 ...
                                       ,-self.workspaceSize (2)/2, self.workspaceSize (2)/2 ...
                                       0,self.maxHeight];        
  
            % Create the required number of bricks
            for i = 1:self.coinCount
            self.coinModel{i} = self.GetCoinModel(['coin',num2str(i)]);
            self.coinModel{i}.base = self.coinModel{i}.base.T * basePose{i} * trotx(-pi/2);
                   
                 % Plot 3D model
                plot3d(self.coinModel{i},0,'workspace',self.workspaceDimensions,'view',[-30,30],'delay',0,'noarrow','nowrist');
                % Hold on after the first plot (if already on there's no difference)
                if i == 1 
                    hold on;
                end
            end

            axis equal
            if isempty(findobj(get(gca,'Children'),'Type','Light'))
                camlight
            end 
        end
        
        % function delete(self)
        %     for index = 1:self.coinCount
        %         handles = findobj('Tag', self.coinModel{index}.name);
        %         h = get(handles,'UserData');
        %         try delete(h.robot); end
        %         try delete(h.wrist); end
        %         try delete(h.link); end
        %         try delete(h); end
        %         try delete(handles); end
        %     end
        % end       
    end

    methods (Static)
        %% GetCoinModel
        function model = GetCoinModel(name)
            if nargin < 1
                name = 'Cow';
            end
            [faceData,vertexData] = plyread('coin.ply','tri');
            link1 = Link('alpha',pi/2,'a',0,'d',0.3,'offset',0);
            model = SerialLink(link1,'name',name);
            
            % Changing order of cell array from {faceData, []} to 
            % {[], faceData} so that data is attributed to Link 1
            % in plot3d rather than Link 0 (base).
            model.faces = {[], faceData};

            % Changing order of cell array from {vertexData, []} to 
            % {[], vertexData} so that data is attributed to Link 1
            % in plot3d rather than Link 0 (base).
            model.points = {[], vertexData};
        end
    end    
end