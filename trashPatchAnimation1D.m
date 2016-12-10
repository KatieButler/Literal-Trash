function trashPatchAnimation1D()
%% For Liv's Sanity 
clf 

%% Variables 
westPatchShorePollutionRate = 4064.18; %kg/year  

oceanDebrisWestPollutionRate = 2177.24; %kg/year

% eastPatchShorePollutionRate = 290.30; %kg/year 
% 
% oceanDebrisEastPollutionRate = 2177.24; %kg/year

diffusion = 0.005425; %kg/year; 

westPatch = 14*16329325.33; %Size in kg

% eastPatch = 16329325.33; %Size in kg 

currentFromWestToEast = (21444.5*5.25); % Averaged current rates in km/year
                                      %Converted into kg/year using density

currentFromEastToWest = (1576.8*5.25); % Averaged current rates in km/year
                                     % Converted into kg/year using density
                                     

westNormal = 1;
eastNormal = 1; 

xMin = 1;
xMax = 10;
yMin = 225000000;
yMax = 230000000;
                                     
%time = 1; % Current time (future iterations will be in years from present.)


%% Running code 

        for i=1:10;
            plot(i,westPatch,'o');
            axis([xMin xMax yMin yMax]);
            westPatch = integral( integral(density*(-currentFromWestToEast)*westNormal, ...
                        xMin, xMax), yMin, yMax)  + integral(integral(gradient(density*westNormal),....
                        xMin, xMax), yMin, yMax);
            
            hold on
        end 

% %         for i=1:10;
%             plot(i,eastPatch,'o');
%             axis([xMin xMax yMin yMax]);
%             eastPatch = integral( integral(density*(-currentFromEastToWest)*eastNormal, ...
%                         xMin, xMax), yMin, yMax)  + integral(integral(gradient(density*eastNormal),....
%                         xMin, xMax), yMin, yMax);
%             
%             hold on
%         end 
%         

end 
