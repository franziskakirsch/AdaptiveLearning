function Cannonball(taskParam, distMean, outcome, background, currentContext, latentState)
%CANNONBALL   Animates the cannonball shot

% number of times that cannonball is printed between cannon and aim
nFrames = 50;

% outcome coordinates
xOut = ((taskParam.circle.rotationRad-5) * sind(outcome));
yOut = ((taskParam.circle.rotationRad-5) * (-cosd(outcome)));
OutcSpot = OffsetRect(taskParam.circle.outcCentSpotRect, xOut, yOut);

% target (mean) coordinates
xTarget = ((taskParam.circle.rotationRad-5) * sind(distMean));
yTarget = ((taskParam.circle.rotationRad-5) * -cosd(distMean));
if ~isequal(taskParam.gParam.taskType, 'chinese')
    TargetSpotEnd = OffsetRect(taskParam.circle.outcCentSpotRect, xTarget, yTarget);
    TargetSpotStart = taskParam.circle.outcCentSpotRect;
else 
    xCannon = (300 * sind(distMean));
    yCannon = (300 * -cosd(distMean));
    TargetSpotEnd = OffsetRect(taskParam.circle.outcCentSpotRect,...
        xTarget, yTarget);
    TargetSpotStart = OffsetRect(taskParam.circle.outcCentSpotRect,...
        xCannon, yCannon);
end
TargetDist = TargetSpotEnd - TargetSpotStart;

% position at which cannonball starts to fly
BallStart = TargetSpotStart + TargetDist/4;

% difference between start and end point
OutcSpotDiff = OutcSpot - BallStart;

% stepsize
Step = OutcSpotDiff / nFrames;

% actual cannonball position
OutcSpotAct = BallStart;

for i = 1:nFrames
    
    if background == true
        LineAndBack(taskParam)
    end
    
    OutcSpotAct = OutcSpotAct + Step;
    if isequal(taskParam.gParam.taskType, 'chinese')
            %currentContext = 1;
            DrawContext(taskParam, currentContext)
            DrawCross(taskParam)
    end
    DrawCircle(taskParam)
    Cannon(taskParam, distMean, latentState)
    PredictionSpot(taskParam)
    Screen('FillOval', taskParam.gParam.window.onScreen, [0 0 0],...
        OutcSpotAct);
    Screen('DrawingFinished', taskParam.gParam.window.onScreen);
    t = GetSecs;
    Screen('Flip', taskParam.gParam.window.onScreen, t + 0.01);
    
end



