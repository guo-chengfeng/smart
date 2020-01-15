function  ispositive(dat)
%ISPOSITIVE Summary of this function goes here
%   Detailed explanation goes here

n=prod(size(dat));
for ii=1:n
    if dat(ii)<0
        nnerr.throw('data must be positive');
    end
end

end

