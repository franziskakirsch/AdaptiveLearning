function SharedInstructions_MainOddballFollowCannon(taskParam, subject, cannon, whichPractice)
    %SHAREDINSTRUCTIONS_MAINODDBALLFOLLOWCANNON   Runs first part of the instructions for change point, oddball, follow
    %cannon and reversal task

    screenIndex = 1;

    while 1
        switch(screenIndex)
            case 1
                if isequal(taskParam.gParam.taskType, 'dresden')
                    txt = 'Kanonenkugeln Abwehren';

                    screenIndex = YourTaskScreen(txt,...
                        taskParam.textures.shieldTxt, screenIndex);
                else
                    screenIndex = screenIndex + 1;
                end
            case 2
                screenIndex = FirstCannonSlide(screenIndex, taskParam, cannon);
            case 3
                [screenIndex, Data, taskParam] = PressSpaceToInitiateCannonShot(taskParam, screenIndex, true, cannon);
                WaitSecs(0.1);
            case 4
                distMean = 290;
                if isequal(taskParam.gParam.taskType, 'dresden')
                    if isequal(subject.group, '1')
                        txt=['Der schwarze Strich zeigt dir die '...
                            'Position der letzten Kugel. Der '...
                            'orangene Strich zeigt dir die '...
                            'Position deines letzten Schildes. '...
                            'Steuere den orangenen Punkt jetzt auf '...
                            'das Ziel der Kanone und dr�cke '...
                            'LEERTASTE.'];
                    else
                        txt=['Der schwarze Strich zeigt Ihnen die '...
                            'Position der letzten Kugel. Der '...
                            'orangene Strich zeigt Ihnen die '...
                            'Position Ihres letzten Schildes. '...
                            'Steuern Sie den orangenen Punkt jetzt '...
                            'bitte auf das Ziel der Kanone und '...
                            'dr�cken Sie LEERTASTE.'];
                    end
                elseif isequal(taskParam.gParam.taskType, 'oddball')
                    txt=['Move the orange spot to the part of the '...
                        'circle, where the cannon is aimed and '...
                        'press SPACE.'];
                elseif isequal(taskParam.gParam.taskType, 'reversal') || isequal(taskParam.gParam.taskType, 'ARC')
                    txt=['Move the orange spot to the part of the '...
                        'circle, where the cannon is aimed and '...
                        'press the left mouse button.'];
                elseif isequal(taskParam.gParam.taskType, 'chinese')
                    txt=['Bewege den orangenen Punkt zu der Stelle '...
                        'auf dem Planeten auf die die Kanone zielt '...
                        'und dr�cke die linke Maustaste.'];
                end
                [screenIndex, Data, taskParam] = MoveSpotToCannonAim...
                    (taskParam, screenIndex, txt, distMean, Data, cannon);
            case 5
                distMean = 290;
                [screenIndex, Data, taskParam] = YouMissedTheCannonBall_TryAgain...
                    (taskParam, screenIndex, Data, distMean, whichPractice);
            case 6
                if isequal(taskParam.gParam.taskType, 'dresden')
                    if isequal(subject.group, '1')
                        txt=['Das Schild erscheint nach dem '...
                            'Schuss. In diesem Fall hast du die '...
                            'Kanonenkugel abgewehrt. '...
                            'Wenn mindestens die H�lfte der Kugel '...
                            'auf dem Schild ist, z�hlt es als '...
                            'Treffer.'];
                    else
                        txt=['Das Schild erscheint nach dem '...
                            'Schuss. In diesem Fall haben Sie die '...
                            'Kanonenkugel abgewehrt. '...
                            'Wenn mindestens die H�lfte der Kugel '...
                            'auf dem Schild ist, z�hlt es als '...
                            'Treffer.'];
                    end
                elseif isequal(taskParam.gParam.taskType, 'oddball')...
                        || isequal(taskParam.gParam.taskType,'reversal')...
                        || isequal(taskParam.gParam.taskType,'ARC')
                    txt=['After the cannon is shot you will see '...
                        'the shield. In this case you caught the '...
                        'ball. If at least half of the ball '...
                        'overlaps with the shield then it is '...
                        'a "catch".'];
                elseif isequal(taskParam.gParam.taskType, 'chinese')
                    txt=['Dein Schild erscheint nach dem Schuss '...
                        'des Raumschiffs. In diesem Fall hast du '...
                        'die Kanonenkugel abgewehrt. Wenn mindestens '...
                        'die H�lfte der Kugel auf dem Schild ist, '...
                        'hast du sie erfolgreich abgewehrt.'];
                end
                win = true;
                [screenIndex, Data] =...
                    AfterCannonIsShotYouSeeTheShield...
                    (taskParam, subject, screenIndex, Data, txt, distMean, win);
            case 7
                if isequal(taskParam.gParam.taskType, 'dresden')
                    if isequal(subject.group, '1')
                        txt = ['Steuere den orangenen Punkt '...
                            'jetzt neben das Ziel der Kanone, so '...
                            'dass du die Kanonenkugel verfehlst '...
                            'und dr�cke LEERTASTE.'];
                    else
                        txt = ['Steuern Sie den orangenen Punkt '...
                            'jetzt bitte neben das Ziel der '...
                            'Kanone, so dass Sie die Kanonenkugel '...
                            'verfehlen und dr�cken Sie LEERTASTE.'];
                    end

                elseif isequal(taskParam.gParam.taskType, 'oddball')
                    txt = ['Now try to place the shield so that '...
                        'you miss the cannonball. Then hit SPACE. '];
                elseif isequal(taskParam.gParam.taskType, 'reversal')...
                         || isequal(taskParam.gParam.taskType, 'ARC')
                    txt = ['Now try to place the shield so '...
                        'that you miss the cannonball. Then hit '...
                        'the left mouse button. '];
                elseif isequal(taskParam.gParam.taskType, 'chinese')
                    txt = ['Versuche nun dein Schild so zu '...
                        'positionieren, dass du die Kanonenkugel '...
                        'verfehlst. Dr�cke dann die linke Maustaste.'];
                end
                distMean = 65;
                [screenIndex, Data, taskParam] = TryToMissTheCannon...
                    (taskParam, screenIndex, Data, txt, distMean, cannon);
            case 8
                Data.outcome = distMean;
                [screenIndex, Data, t] =...
                    YouCaughtTheCannonball_TryToMissIt...
                    (taskParam, screenIndex, Data, distMean);
            case 9
                if isequal(taskParam.gParam.taskType, 'dresden')
                    if isequal(subject.group, '1')
                        txt=['In diesem Fall hast du die '...
                            'Kanonenkugel verpasst.'];
                    else
                        txt=['In diesem Fall haben Sie die '...
                            'Kanonenkugel verpasst.']; 
                    end
                elseif isequal(taskParam.gParam.taskType, 'oddball')...
                        ||isequal(taskParam.gParam.taskType,'reversal')...
                        ||isequal(taskParam.gParam.taskType,'ARC') 
                    txt='In this case you missed the cannonball.';
                elseif isequal(taskParam.gParam.taskType, 'chinese')
                    txt='In diesem Fall hast du die Kanonenkugel verfehlt.';
                end
                win = true;
                [screenIndex, Data, t] =...
                    InThisCaseYouMissedTheCannonball...
                    (taskParam, subject, screenIndex, Data, t, txt, distMean, win);
            case 10
                if isequal(taskParam.gParam.taskType, 'dresden')
                    if isequal(subject.group, '1')
                        txt = sprintf(['Wenn du Kanonenkugeln '...
                            'abwehrst, kannst du Geld verdienen. '...
                            'Wenn das Schild %s ist, verdienst '...
                            'du %s CENT wenn du die Kanonenkugel '...
                            'abwehrst. Wenn das Schild %s ist, '...
                            'verdienst du nichts. Ebenso wie die '...
                            'Farbe, kann auch die Gr��e deines '...
                            'Schildes variieren. Die Farbe und '...
                            'die Gr��e des Schildes siehst '...
                            'du erst, nachdem die Kanone '...
                            'geschossen hat. Daher versuchst du am '...
                            'besten jede Kanonenkugel abzuwehren.'...
                            '\n\nUm einen Eindruck von der '...
                            'wechselnden Gr��e und Farbe des '...
                            'Schildes zu bekommen, kommt jetzt '...
                            'eine kurze �bung.\n\n'], colRew,...
                            num2str(100*taskParam.gParam.rewMag),...
                            colNoRew);
                    else
                        txt = sprintf(['Wenn Sie Kanonenkugeln '...
                            'abwehren, k�nnen Sie Geld verdienen. '...
                            'Wenn das Schild %s ist, verdienen '...
                            'Sie %s CENT wenn Sie die Kanonenkugel '...
                            'abwehren. Wenn das Schild %s ist, '...
                            'verdienen Sie nichts. Ebenso wie die '...
                            'Farbe, kann auch die Gr��e Ihres '...
                            'Schildes variieren.Die Farbe und die '...
                            'Gr��e des Schildes sehen Sie erst, '...
                            'nachdem die Kanone geschossen hat. '...
                            'Daher versuchen Sie am besten jede '...
                            'Kanonenkugel abzuwehren.\n\n'...
                            'Um einen Eindruck von der wechselnden '...
                            'Gr��e und Farbe des Schildes zu '...
                            'bekommen, kommt jetzt eine kurze '...
                            '�bung.\n\n'], colRew, num2str...
                            (100*taskParam.gParam.rewMag), colNoRew);
                    end
                end
                [screenIndex, Data] = YourShield...
                    (taskParam, subject, screenIndex, Data, txt);

            case 11
                [screenIndex, Data] = ShieldPractice...
                    (taskParam, subject, screenIndex);
                if isequal(taskParam.gParam.taskType, 'chinese') ||...
                        isequal(taskParam.gParam.taskType, 'ARC')
                    screenIndex = 25;
                end
            case 12
                screenIndex = TrialOutcomes(screenIndex);                 
            case 13

                distMean = 290;
                if isequal(taskParam.gParam.taskType, 'dresden')
                    if isequal(subject.group, '1')
                        txt = ['Versuche die Kanonenkugel jetzt '...
                            'wieder zu abzuwehren.'];
                    else
                        txt = ['Versuchen Sie die Kanonenkugel '...
                            'jetzt wieder zu abzuwehren.'];
                    end
                elseif isequal(taskParam.gParam.taskType, 'oddball')...
                        || isequal(taskParam.gParam.taskType,...
                        'reversal')
                    txt='Now try to catch the ball.';
                end

                [screenIndex, Data] = MoveSpotToCannonAim...
                    (screenIndex, txt, distMean, Data);

            case 14

                [screenIndex, Data] =...
                    YouMissedTheCannonBall_TryAgain...
                    (screenIndex, Data, distMean);

            case 15

                if isequal(taskParam.gParam.taskType, 'dresden')
                    if isequal(subject.group, '1')
                        if isequal(whichPractice, 'followOutcome')
                            txt = sprintf(['Weil du die '...
                                'Kanonenkugel abgewehrt '...
                                'hast und der Korb %s war, '...
                                'h�ttest du jetzt %s CENT '...
                                'verdient.'], colRew,...
                                num2str(100*taskParam.gParam.rewMag));
                        else
                            txt = sprintf(['Weil du die '...
                                'Kanonenkugel abgewehrt '...
                                'hast und das Schild %s war, '...
                                'h�ttest du jetzt %s CENT '...
                                'verdient.'], colRew,...
                                num2str(100*taskParam.gParam.rewMag));
                        end
                    else
                        if isequal(whichPractice, 'followOutcome')
                            txt = sprintf(['Weil Sie die '...
                                'Kanonenkugel abgewehrt '...
                                'haben und der Korb %s war, '...
                                'h�tten Sie jetzt %s CENT '...
                                'verdient.'], colRew,...
                                num2str(100*taskParam.gParam.rewMag));
                        else
                            txt = sprintf(['Weil Sie die '...
                                'Kanonenkugel abgewehrt '...
                                'haben und das Schild %s war, '...
                                'h�tten Sie jetzt %s CENT '...
                                'verdient.'], colRew,...
                                num2str(100*taskParam.gParam.rewMag));
                        end
                    end
                elseif isequal(taskParam.gParam.taskType, 'oddball')...
                        ||isequal(taskParam.gParam.taskType,'reversal')
                    txt = sprintf(['You caught the ball and the '...
                        'shield is %s. So you would earn %s CENTS.'],...
                        colRew, num2str(100*taskParam.gParam.rewMag));
                end

                win = true;
                [screenIndex, Data] =...
                    AfterCannonIsShotYouSeeTheShield...
                    (screenIndex, Data, txt, distMean, win);

            case 16

                if isequal(taskParam.gParam.taskType, 'dresden')
                    if isequal(subject.group, '1')
                        txt = ['Versuche die Kanonenkugel beim '...
                            'n�chsten Schuss zu verfehlen.'];
                    else
                        txt=['Versuchen Sie die Kanonenkugel '...
                            'bitte beim n�chsten Schuss '...
                            'zu verfehlen.'];
                    end
                elseif isequal(taskParam.gParam.taskType, 'oddball')...
                        ||isequal(taskParam.gParam.taskType,'reversal')
                    txt = 'Now try to miss the ball.';
                end
                distMean = 35;
                [screenIndex, Data] = TryToMissTheCannon...
                    (screenIndex, Data, txt, distMean);

            case 17

                Data.outcome = distMean;
                [screenIndex, Data, t] =...
                    YouCaughtTheCannonball_TryToMissIt...
                    (screenIndex, Data, distMean);

            case 18

                if isequal(taskParam.gParam.taskType, 'dresden')
                    if isequal(subject.group, '1')
                        txt=['Weil du die Kanonenkugel verpasst '...
                            'hast, h�ttest du nichts verdient.'];
                    else
                        txt=['Weil Sie die Kanonenkugel verpasst '...
                            'haben, h�tten Sie nichts verdient.'];
                    end
                elseif isequal(taskParam.gParam.taskType, 'oddball')...
                        ||isequal(taskParam.gParam.taskType,'reversal')
                    txt = ['You missed the ball so you would earn '...
                        'nothing.'];
                end
                win = true;

                [screenIndex, Data, t] =...
                    InThisCaseYouMissedTheCannonball...
                    (screenIndex, Data, t, txt, distMean, win);

            case 19

                distMean = 190;

                if isequal(taskParam.gParam.taskType, 'dresden')
                    if isequal(subject.group, '1')

                        txt = ['Versuche die Kanonenkugel jetzt '...
                            'wieder zu abzuwehren.'];
                    else
                        txt = ['Versuchen Sie bitte die '...
                            'Kanonenkugel wieder zu abzuwehren.'];

                    end
                elseif isequal(taskParam.gParam.taskType, 'oddball')...
                        ||isequal(taskParam.gParam.taskType,'reversal')
                    txt='Now try to catch the ball.';
                end

                [screenIndex, Data] =...
                    MoveSpotToCannonAim...
                    (screenIndex, txt, distMean, Data);

            case 20

                screenIndex =...
                    YouMissedTheCannonBall_TryAgain...
                    (screenIndex, Data, distMean);

            case 21

                if isequal(taskParam.gParam.taskType, 'dresden')
                    if isequal(subject.group, '1')


                        txt=sprintf(['Du hast die Kanonenkugel '...
                            'abgewehrt, aber das Schild war %s. '...
                            'Daher h�ttest du nichts verdient.'],...
                            colNoRew);

                    else

                        txt=sprintf(['Sie haben die Kanonenkugel '...
                            'abgewehrt, aber das Schild war %s. '...
                            'Daher h�tten Sie nichts verdient.'],...
                            colNoRew);

                    end
                elseif isequal(taskParam.gParam.taskType, 'oddball')...
                        ||isequal(taskParam.gParam.taskType,'reversal')
                    txt=sprintf(['You caught the ball and your '...
                        'shield was %s so you would earn nothing.'],...
                        colNoRew);
                end


                win = false;
                [screenIndex, Data] =...
                    AfterCannonIsShotYouSeeTheShield...
                    (screenIndex, Data, txt, distMean, win);

            case 22

                Data.outcome = distMean;
                distMean = 160;

                if isequal(taskParam.gParam.taskType, 'dresden')
                    if isequal(subject.group, '1')

                        txt=['Versuche die Kanonenkugel bei '...
                            'n�chsten Schuss zu verfehlen.'];
                    else
                        txt=['Versuchen Sie bitte die Kanonenkugel '...
                            'bei n�chsten Schuss zu verfehlen.'];
                    end
                elseif isequal(taskParam.gParam.taskType, 'oddball')...
                        ||isequal(taskParam.gParam.taskType,'reversal')
                    txt = 'Now try to miss the ball.';
                end
                [screenIndex, Data] =...
                    TryToMissTheCannon...
                    (screenIndex, Data, txt, distMean);

            case 23

                distMean = 160;
                Data.outcome = distMean;
                [screenIndex, Data, t] =...
                    YouCaughtTheCannonball_TryToMissIt...
                    (screenIndex, Data, distMean);

            case 24

                if isequal(taskParam.gParam.taskType, 'dresden')
                    if isequal(subject.group, '1')

                        txt=['Weil du die Kanonenkugel verpasst '...
                            'hast, h�ttest du nichts verdient.'];
                    else
                        txt=['Weil Sie die Kanonenkugel verpasst '...
                            'haben, h�tten Sie nichts verdient.'];
                    end
                elseif isequal(taskParam.gParam.taskType, 'oddball')...
                        ||isequal(taskParam.gParam.taskType,'reversal')
                    txt = ['You missed the ball so you would earn '...
                        'nothing.'];
                end
                %win = false;
                [screenIndex, Data, t] =...
                    InThisCaseYouMissedTheCannonball...
                    (screenIndex, Data, t, txt, distMean, false);

            case 25

                if isequal(whichPractice, 'mainPractice')...
                        || (isequal(whichPractice,...
                        'followCannonPractice')...
                        && subject.cBal == 4)...
                        || (isequal(whichPractice,...
                        'followCannonPractice')...
                        && subject.cBal == 5)...
                        || (isequal(whichPractice,...
                        'followCannonPractice')...
                        && subject.cBal == 6)

                    warning('turned first practice off')
                    %MainAndFollowCannon_CannonVisibleNoNoise



                    warning('turned second practice off')
                    MainAndFollowCannon_CannonVisibleNoise(whichPractice, taskParam, subject)

                    LoadData = 'CP_Noise';

                    %condition = 'mainPractice_2';
                    condition = 'onlinePractice';

                 %keyboard
%                     header = 'new practice'
%                     txt = 'new practice' 
%                     feedback = false;
%                     fw = al_bigScreen(taskParam,...
%                         taskParam.strings.txtPressEnter,...
%                         header, txt, feedback);

                %for a = 1:5
                 %   sel = 2:10;
                    [taskData, Data] =  al_mainLoop(taskParam,...
                        taskParam.gParam.haz(1),...
                        taskParam.gParam.concentration(3),...
                        condition, subject);
                  %  txt=['New Text'];

                   % distMean = Data.distMean(1); %290;
                    %%outcome = 178;
                    %tickInstruction.savedTickmark = nan;
                    %tickInstruction.previousOutcome = nan;
                    %tickInstruction.previousPrediction = nan;
                    %cannon = true;
                    %[taskParam, fw, Data, savedTickmark] =...
                    %    al_instrLoopTxt(taskParam,...
                    %    txt, cannon, 'space', distMean, tickInstruction);
                %end
                elseif isequal(whichPractice, 'oddballPractice')

                    oddballPractice


                elseif isequal(taskParam.gParam.taskType, 'reversal')

                    reversalPractice

                elseif isequal(taskParam.gParam.taskType, 'dresden')

                    FollowCannonJustInstructions

                elseif (isequal(whichPractice, 'chinese'))

                    chinesePractice(taskParam, subject)

                end

                break
        end
    end
end