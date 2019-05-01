%% Simpson.m
% Created by: Tony Priolo
% Last edited on 4/17/2019
% Mech 105, Dr Bechara.
function I =  Simpson(x,y)
%% Check if Inputs are same length.
if length(x)-length(y) ~= 0
    error('Inputs "(x,y)" are not the same length.')
    return
else
    disp('The inputs "(x,y)" are the same length.')
end
%% Check that the input "x" is equally spaced.
spacingcheck = linspace(x(1),x(end),length(x));
if isrow(x) == 1
    spacingtest = isequal(spacingcheck,x);
else
    spacingtest = isequal(spacingcheck',x);
end
if spacingtest ~= 1
    error('Input "x" is NOT equally spaced')
    return
else
    disp('Input "x" is equally spaced')
end
%spacing = range(x(2:end)-x(1:end-1));
%if spacing ~= 0
%    error('Input "x" is NOT equally spaced')
%    return
%else
%    disp('Input "x" is equally spaced')
%end
%% Warn the user if there is an odd # of intervals.
 if rem((length(x)-1),2) == 1
     warning('There are an odd # of intervals.')
     disp('Trapezoidal rule has to be used on the last interval.')
 else
     disp('There are an even # of intervals.')
 end
%% Script
if rem((length(x)-1),2) ~= 1 % (Even # of intevals)
    M = ((x(end))+(x(1)))/2;
    mid = abs(x-M)<=10^-5;
    % = (h/3)*(f(x0)+4(f(x1))+f(x2)
    I = ((max(x))-(min(x)))*((y(1))+(4*(y(mid)))+(y(end)))*(1/6)
    %sumI = h/3*(y(1)+2*sum(y(3:2:end-2))+4*sum(y(2:2:end))+y(end))
else % (Odd # of intervals)
    M = ((x(end)-1)+(x(1)))/2;
    oddmid = (abs(x-M)<=10^-5);
    % = (h/3)*(f(x0)+4(f(x1))+f(x2)
    SimpI = ((max(x)-1)-(min(x)))*((y(1))+(4*(y(oddmid)))+(y(end-1)))*(1/6);
    % = (b-a)*(f(a)+f(b))*(1/2)
    TrapI = (x(end)-x(end-1))*(y(end-1)+y(end))*(1/2);
    I = SimpI + TrapI
end
trapz_test = trapz(x,y)
if length(x) == 2
    I = TrapI
    disp(['I = ', num2str(I)])
end
true_percent_relative_error = ((abs((trapz_test - I)))/(trapz_test))*(100)
%fprintf('I = \n')
end