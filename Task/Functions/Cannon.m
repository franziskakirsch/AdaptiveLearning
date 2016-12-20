function Cannon(taskParam, distMean, latentState, symbol)
%CANNON   Prints the cannon image

if nargin == 3
    
    symbol = true;
    
end

if ~isequal(taskParam.gParam.taskType, 'chinese')
    
    Screen('DrawTexture', taskParam.gParam.window.onScreen,...
        taskParam.textures.cannonTxt,[], taskParam.textures.dstRect,...
        distMean, [], 0, [0 0 0], [], []);
else
    
    xPredS = ((taskParam.circle.chineseCannonRad) *...
        sin(distMean*taskParam.circle.unit));
    yPredS = ((taskParam.circle.chineseCannonRad) *...
        (-cos(distMean*taskParam.circle.unit)));
    cannonPosition = OffsetRect(taskParam.textures.dstRect, xPredS,...
        yPredS);
    
    distMeanSpace = distMean + 180;

        if taskParam.symbol == false
             Screen('DrawTexture', taskParam.gParam.window.onScreen,...
                        taskParam.textures.rocketTxt,[], cannonPosition,...
                        distMeanSpace, [], 0, [0 0 0], [], []);
        else
        if latentState == 0
            Screen('DrawTexture', taskParam.gParam.window.onScreen,...
                taskParam.textures.rocketTxt,[], cannonPosition,...
                distMeanSpace, [], 0, [0 0 0], [], []);
        elseif latentState == 1
            Screen('DrawTexture', taskParam.gParam.window.onScreen,...
                taskParam.textures.rocketTxt_lightning,[], cannonPosition,...
                distMeanSpace, [], 0, [0 0 0], [], []);
%             Screen('DrawTexture', taskParam.gParam.window.onScreen,...
%                 taskParam.textures.rocketTxt_lightning,[], cannonPosition,...
%                 distMeanSpace, [], 0, [0 0 0], [], []);
        elseif latentState == 2
            Screen('DrawTexture', taskParam.gParam.window.onScreen,...
                taskParam.textures.rocketTxt_star,[], cannonPosition,...
                distMeanSpace, [], 0, [0 0 0], [], []);
        elseif latentState == 3
            Screen('DrawTexture', taskParam.gParam.window.onScreen,...
                taskParam.textures.rocketTxt_swirl,[], cannonPosition,...
                distMeanSpace, [], 0, [0 0 0], [], []);
        end
        end
    
    
end


