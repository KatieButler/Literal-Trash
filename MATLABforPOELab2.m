function serData = MATLABforPOELab2()        
hold all; 
ser = serial('COM4');                             % this is the port the Ardunio is on
set(ser, 'BaudRate', 9600, 'Timeout', 0.005);     % 9600 is the serial intializing port, timeout is the max time to wait for data
fopen(ser);                                       % open the serial reader

finishup = onCleanup(@() cleanup(ser));           % removes remaining data from the serial reader                                                                                            
    function cleanup(s)
        fclose(s);                                % close the serial reader
        delete(s);                                % delete all information stored in the serial
        clear s                                   % remove data from MATLAB
        disp('Clean!')                            % tells you it cleaned: if it doesn't unplug and replug arduino
    end

serData = [];                                     % initialize matrix to put serial data

fscanf(ser);                                      % pulls data from serial text file

while(true)  
    if(get(ser, 'BytesAvailable') > -1)                 % if there is data coming in from the arduino
        value = sscanf(fscanf(ser), '%u, %u, %u');      % sscanf reads formatted data from string, fscanf reads data from the text file (look up uses of % d and % u and % f)
        if value(3) > 29;
            break                                                                         
        else % if scanning is still going
            serVect = [value(1), value(2), value(3)];
            serData = vertcat(serData, serVect); % this is where you decide what to do with the data you are importing 
        end
    end
end 

graphSerData(serData) 

    function graphSerData(serData) 
        clf
        sensorOutput = serData(:,1);                % First column of matrix is the sensor output
        pan = serData(:,2);                         % Second column of matrix is the pan angle
        pan = (((pan + 70) * 2 * pi) / 360);        % Convert to radians
        tilt = serData(:,3);                        % Third column of matrix is the tilt angle
        tilt = (((tilt - 20) * 2 * pi) / 360);      % Convert to radians
        
        % Sensor and Distance Calibration Equation
        distance = 80 + (549.6439154) * ((0.9864453564 ).^(sensorOutput));
        % Polar to Cartesian Coordinates
        x = distance .* cos(tilt) .* cos(pan);      
        y = distance .* cos(tilt) .* sin(pan);
        z = distance .* sin(tilt);

        scatter3(x,y,z)                             % Scatter plot in 3 dimensions
        xlabel('x')                                 % Label x axis
        ylabel('y')                                 % Label y axis
        zlabel('z')                                 % Label z axis
    end 
end 

