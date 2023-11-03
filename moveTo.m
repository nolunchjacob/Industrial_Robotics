function [trajectory, currentStep, ObjectVerts] = moveTo(StartPose, EndPose, Robot, InitialGuess, Object, ObjectVerts)
    if nargin == 5
        trfix = inv(Robot.model.fkine(Robot.model.getpos)) * [ObjectVerts, ones(size(ObjectVerts, 1), 1)];

        ObjectAttached = 1;
    else
        ObjectAttached = 0;
    end
    
    qStart = Robot.model.ikcon(StartPose, InitialGuess);
    qEnd = Robot.model.ikcon(EndPose, InitialGuess);
    
    % Determine Steps required based on distance
    Start = Robot.model.fkineUTS(qStart);
    End = Robot.model.fkineUTS(qEnd);
    StartTr = Start(1:3, 4);
    EndTr = End(1:3, 4);
    travelDistance = norm(StartTr - EndTr);
    steps = round(100 * travelDistance + 15);
    
    % Generate Trajectory
    trajectory = jtraj(qStart, qEnd, steps);
    
    for i = 1:size(trajectory, 1)
        Robot.model.animate(trajectory(i, :));
        
        if ObjectAttached == 1
            UpdateObject = Robot.model.fkine(trajectory(i, :)).T * trfix;
            trvert = UpdateObject(1:3, :)';
            set(Object, 'Vertices', trvert); % animate trajectory
        end
        
        currentStep = i;
        drawnow;
        pause(0.05);
        
        if ObjectAttached == 1
            ObjectVerts = get(Object, 'Vertices');
        end
    end
end
