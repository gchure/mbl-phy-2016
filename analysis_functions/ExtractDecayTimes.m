function decayVector = ExtractDecayTimes(V, T)
% EXTRACTDECAYTIMES Returns a vector of indices at which cells in a
% photobleaching experiment reach a user provided value.
%    decayVector = EXTRACTDECAYTIMES(V,T) returns the index in which a
%    threshold value T is met in each row of the provided vector V.

%Iterate through each row.
vecSize = size(V);
for i=1:vecSize(1)
    %Extract each bleach trajectory.
    traj = V(i,:);
    %Find the index at which the threshold is met.
    timePoint = find(traj <= T);
    decayVector(i) = timePoint(1);     
end
end

