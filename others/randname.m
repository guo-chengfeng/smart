function namesList = randname(n)
%RANDNAME
for im = 1:n
    t = randi(26,1,8);
    names = [];
    for in = 1:8
        names = [names,char(t(in)+96)];
    end
    names = [names,'-'];
    t = randi(9,1,1);
    names = [names,num2str(t)];
    namesList{im} = names;
end

end

