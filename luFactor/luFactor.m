%% luFactor
% Created By: Anthony Priolo
% Last Edited: 4/3/2019
% Class: Mech 105
%% Inputs/Outputs
% The Inputs: A
% "A" - Original coefficient matrix
% The Outputs: L, U, P
% "L" - The lower triangular matrix
% "U" - The upper triangular matrix
% "P" - The pivot matrix
%%
function [L, U, P] = luFactor(A)
    dimension = size(A,1);
    Atwo = A;
    % Set "P" as identity matrix with dimensions that are = original matrix
    P = eye(dimension);
    % Set "L" as identity matrix with dimensions that are = original matrix
    L = eye(dimension);
    % Set "U" as zeros matrix with dimensions that are = original matrix
    U = zeros(dimension);
    for c = 1:dimension-1
        [~,rowwithmax] = max(abs(Atwo(:,1)));
        % Determine which row has the biggest value in said column
        rowwithmax = dimension-(dimension-c+1)+rowwithmax;
        % Pivot
        Atwo([c rowwithmax],:) = Atwo([rowwithmax c],:);
        % Pivot P
        P([c rowwithmax],:) = P([rowwithmax c],:);
        for row = c+1:dimension % Fill U
            L(row,c) = Atwo(row,c) / Atwo(c,c);
            for col = 1:dimension
                U(c,col) = Atwo(c,col);
                Atwo(row,col) = Atwo(row,col) - L(row,c)*Atwo(c,col);
            end
        end % wrap up
    end
    U(:,end) = Atwo(:,end);
    %% Outputs/Input
    % Show P
    fprintf('"P" = Pivot Matrix: ');
    P
    % Show A
    fprintf('"A" = Original/Starting Matrix: ');
    A
    % Show L
    fprintf('"L" = Lower Triangular Matrix: ')
    L
    % Show U
    fprintf('"U" = Upper Triangular Matrix: ')
    U
    %% Prove P*A == L*U
    %Show L*U
    fprintf('"L*U" = L multiplied by U: ')
    L_multiplied_by_U = L*U
    % Show P*A
    fprintf('"P*A" = P multiplied by A: ')
    P_multiplied_by_A = P*A
    % Test that L*U = P*A
    fprintf('Test that P*A == L*U')
    Test = P*A == L*U
    % Some values of 'Test' might be zero, due to the computer, not the
    % function
    % Sometimes, bugs out and says variables are undefined, but everything
    % checks out; sometimes it doesn't