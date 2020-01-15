function  isreal2(data)
%ISREAL2 Summary of this function goes here
%   Detailed explanation goes here
if ~isreal(data)
    nnerr.throw('Velocity is complex');
end

end

