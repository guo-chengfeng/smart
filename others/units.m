function data = units(unitName)
%UNITS return the unit
%   data = units(unitName)
switch unitName
    case 'ps'
        data = 1e-12;
    case 'ns'
        data = 1e-9;
    case 'us'
        data = 1e-6;
    case 'ms'
        data = 1e-3;
    case 's'
        data = 1;
    case 'um'
        data = 1e-6;
    case 'mm'
        data = 1e-3;
    case 'cm'
        data = 1e-2;
    case 'dm'
        data = 1e-1;
    case 'm'
        data = 1;
    case 'km'
        data = 1e3;
    case 'foot'
        data = 0.3048;
    case 'inch'
        data = 0.0254;
    case 'mile'
        data = 1609.344;
    case 'yard'
        data = 0.0762;     
    case 'Hz'  
        data = 1;
    case 'KHz' %3-30Khz 特低频(ULF)；30-300KHz 低频(LF); 300-3000KHz 中频(MF） 
        data = 1e3;
    case 'MHz' %3-30MHz 高频(HF)； 30-300MHz 甚高频(VHF)；300-3000MHz 特高频(UHF）
        data = 1e6;
    case 'GHz' %3-30GHz 超高频(SHF)；30-300GHz 极高频(EHF)
        data = 1e9;
    otherwise
        data = [];
end

end

