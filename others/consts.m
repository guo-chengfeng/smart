function data = consts(constName)
%CONSTS return a fundamental physical constant
%   data = consts(constName)
switch constName
    case 'C'
        data = 299792458;
    case 'mu0'
        data = 4*pi*1e-7;
    otherwise
        data = [];
end


end

