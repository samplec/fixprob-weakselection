function [rho0, rho1, iso] = WeakSelectionFixProb(N,W,Initial)
%%% This function calculates the fixation probability on a graph
%%% under weak selection with either uniform or temperature initialization
% Input N: size of graph
% Input W: adjaceny matrix of graph
% Input Initial:  0 for uniform initialization;  1 for temperature initialization
% Output rho0: zeroth order fixation probability (neutral drift)
% Output rho1: first order fixation probability (effect of weak selection)
% Output iso: boolean check for isothermal graph; returns 2 if the system is unsolvable

%% Define variables
Ntau = nchoosek(N,2);  %number of unique taus (remeeting times) to solve
wdeg = sum(W,2);  %weighted degree
wdeginv = 1./wdeg; %reciprocal of weigthed degree
Wtilde = sum(wdeginv); %sum of inverse weigthed degrees
P = W.*wdeginv; %step probabilities
Temp = sum(P,1); %node temperature
iso = all((Temp < 1 + 10*eps) & (Temp > 1 - 10*eps)); %check for isothermal graph

%% Solve for taus (coalescence times)
% Determine indices of non-zero taus
ind = zeros(Ntau,2);
k = 0;
for i = 1 : N
    for j = i + 1 : N
        k = k + 1;
        ind(k,:) = [i;j];
    end
end

% Determine A coefficient matrix
A = zeros(Ntau,Ntau);
denom = sum(Temp(ind),2);
b = 2./denom;
for row = 1 : Ntau
    for col = row + 1 : Ntau
        if ind(row,1) == ind(col,1)
            A(row,col) = P(ind(col,2),ind(row,2))/denom(row);
            A(col,row) = P(ind(row,2),ind(col,2))/denom(col);
        elseif ind(row,2) == ind(col,1)
            A(row,col) = P(ind(col,2),ind(row,1))/denom(row);
            A(col,row) = P(ind(row,1),ind(col,2))/denom(col);
        elseif ind(row,2) == ind(col,2)
            A(row,col) = P(ind(col,1),ind(row,1))/denom(row);
            A(col,row) = P(ind(row,1),ind(col,1))/denom(col);
        end
    end
end


% Check if system of equations is unsolvable
if any(any(isnan(A)))  %check if A has non-finite values
    rho0 = NaN; rho1 = NaN; iso = 2;
elseif rank(eye(Ntau,Ntau) - A) < Ntau  %check if (I-A) is singular
    rho0 = NaN; rho1 = NaN; iso = 2;
else
    % Solve for tau
    if (Initial == 0)  %Uniform Initialization
        tau = (eye(Ntau,Ntau) - A)\b;  %(I-A)tau = b
    else %Temperature Initialization
        tau = (eye(Ntau,Ntau) - A)\ones(Ntau,1); %(I-A)tau = 1
    end
    
    %define symmetric matrix for tau_ij
    TauMatrix = tril(ones(N),-1);
    TauMatrix(TauMatrix==1) = tau;
    TauMatrix = TauMatrix + TauMatrix';
    
    
    %% Find fixation probability - neutral drift
    if (Initial == 0)  %Uniform Initialization
        rho0 = 1/N;
    else %Temperature Initialization
        rho0 = (wdeginv'*W*wdeginv)./(N*Wtilde);
    end
    %% Find fixation probability - Weak Selection Coefficient
    rho1 = (wdeginv'*(W.*TauMatrix)*wdeginv)./(2*N*Wtilde);
end
end