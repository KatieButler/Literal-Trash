
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
                                     
%time = 1; % Current time (future iterations will be in years from present.)


%% Running code 

        for i=1:10; 
            plot(westPatch,'o')
            axis([0 10 0 1000000000]); 
            hold on
            westPatch = (westPatch + westPatchShorePollutionRate + oceanDebrisWestPollutionRate)- (diffusion + currentFromWestToEast) + currentFromEastToWest; 
            plot(westPatch,'o');
        end 

%         for i=1:10; subplot(eastPatch(i, 1:10), 'r'); axis([0 10e+9 0 10]); 
%         eastPatch = (eastPatch + eastPatchShorePollutionRate + oceanDebrisEastPollutionRate)- (diffusion + currentFromEastToWest) + currentFromWestToEast; 
%         end
%         hold on
        

end 