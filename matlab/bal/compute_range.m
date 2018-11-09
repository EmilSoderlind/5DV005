function [table, flag]=compute_range(param,v0,theta,method,dt,maxstep,print)

% COMPUTE_RANGE Computes the range as function of the elevation
%
% CALL SEQUENCE: [table, flag]=compute_range(param,v0,theta,method,dt,maxstep,print)
%
% INPUT:
%   param     a structure describing of the environment and the shell
%                param.mass   the mass of the shell
%                param.cali   the caliber of the shell
%                param.drag   a function computing the drag coeffient
%                param.atmo   a function computing the atmosphere
%                param.grav   a function computing gravity
%                param.wind   a function computing the wind
%   v0        the muzzle velocity of the gun
%   theta     an array of elevations of dimension 1
%   method    a string describing the method used to compute the trajectory
%   dt        the typical time step, the last time step is allowed to be 
%             shorter
%   maxstep   the maximum number of time steps allowed
%   print     an optional argument, default value is false
%                if print=true, then the results are printed
%
% OUTPUT:
%   table     a two dimensional array, such that
%               table(1,j) = theta(j)
%               table(2,j) = the range obtained with elevation theta(j)
%               table(3,j) = the corresponding flight time 
%   flag      if flag =  1, then everything went smoothly
%             if flag = -j, then execution failed using elevation j
%
% Failure is typically due to MAXSTEP being to small.
%
% MINIMAL WORKING EXAMPLE: compute_range_mwe1
%
% See also: COMPUTE_ELEVATION, FIRE, RANGE_RK1, RANGE_RKX, TARGET

% PROGRAMMING by Carl Christian Kjelgaard Mikkelsen (spock@cs.umu.se)
%  Fall 2014 : Initial programming and testing
%  2015-09-22: Integrated global variables m, k, g into structure
%  2015-09-22: Minor improvement of documentation
%  2015-10-31: Replaced structure const with mandatory PARAM
%  2016-06-27: Integrated displaytable()
%  2016-09-09: Adapted function to SHELL4A

% Determine the number of elements in THETA and create a one dimensional
% copy called ELEV (elevation)
m=numel(theta); elev=reshape(theta,1,m); 

% Artillery computations are not trivial, but let us be optimistic :)
flag=1;

% Initialize the table
table=zeros(3,m);

% Computing a large table can take time, especially if dt is small.
% Printing some form of progress indicator is a courtesy to the user.
fprintf('\nProgress indicator ');

% Loop over the input angles
for j=1:m 
    % Display a primitive progress indicator
    fprintf('.'); 
    % Compute the ith range
    [r, rangeflag, t, ~]=range_rkx(param,v0,elev(j),method,dt,maxstep);
    % Save the elevation
    table(1,j)=elev(j);
    % But .... Did the shell hit the ground?
    if (rangeflag==0) 
        % Failure. A more advanced routine would double MAXSTEP and try again!
        fprintf('\nInsufficient flight time allocated for elevation = %f',elev(j));
        % Here we signal failure ....
        flag=-j;
        % Record NaN because humans often forget to check flags
        table(2,j)=NaN; table(3,j)=NaN;
        % ... and break out of the loop
        break;
    else
       % Success! Save the computed values
       table(2,j)=r; table(3,j)=t(end);
    end
end

% Remove any trailing zeros from output arrays
table=table(:,1:j);

% Skip a few lines
fprintf('\n\n');
        
% Check if the user wants the output printed nicely or not?
if exist('print','var')
    if print==true
        %--------------------------------------------------------------------------
        % Prepare the output for printing.
        %--------------------------------------------------------------------------
        
        % Select the data for printing
        data=[table(1,:)'*180/pi table(2,:)' table(3,:)'];
        
        % Define the column headings
        colheadings = {'Elevation (degrees)','Range (meters)','Flight time (seconds)'};
        
        % Set the widths of the columns
        wids=[19 14 22];
        
        % Define the format specification
        fms={'.2f','.6e','.6e'};
        
        % Print the data nicely
        displaytable(data,colheadings,wids,fms);
        
    end
end