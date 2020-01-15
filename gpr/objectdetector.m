function objectdetector(filename)
data=gfreadfile(filename);
[Nz,Nx]=size(data);
trace_mean=mean(data(:,5:54),2);
amp=data-data;
N=2;
Wn=0.2;
[B,A]=butter(N,Wn,'high');
H=freqz(B,A,Nz);
H=abs(H);

%instantaneous amplitude
for in=55:Nx-60
    trace=data(:,in-2:in+2);
    trace=gfsmooth(trace);
    trace=medfilt2(trace);
    trace=gfsmooth(trace);
    trace=trace(:,3);
    trace_mean=0.05*trace+0.95*trace_mean;
    trace=trace-trace_mean;
    %     trace=smooth(trace);
    trace=abs(hilbert(trace));
    trace=trace.*H;
    amp(:,in)=trace;
end
% gfplot(amp)

data=amp;
% coarse travel time
dmean=mean(data);
[nz,nx]=size(data);
for in=1:nx
    data(:,in)=data(:,in)+dmean(in)+eps;
end
len=30;
tt=data-data;
for iz=len+1:nz-len
    sumline1=sum(data(iz-len+1:iz,:));
    sumline2=sum(data(iz+1:iz+len,:));
    tt(iz,sumline2./sumline1>1.5)=1;
end

mask=fones(10,20);
mask(:,11:20)=0;
CoarseTraveTimes=conv2(tt,mask,'same');
CoarseTraveTimes(CoarseTraveTimes<40)=0;
% gdis(CoarseTraveTimes)

stableTh=30;
stableid=0;
isObject=0;
% fine travel time
[~,finett]=max(CoarseTraveTimes);
gdis(CoarseTraveTimes);
hold on
% finett=medfilt1(finett);
finett=finett-finett+1;
for in=55:Nx
    trace=CoarseTraveTimes(:,in);
    [~,finett(in)]=max(trace);
    if finett(in)==1
        finett(in)=nan;
    end
    if isObject==1 && abs(finett(in)-finett(in-1))>40
        [~,finett(in)]=max(trace(finett(in-1)-20:finett(in-1)+20));
        finett(in)=finett(in)+finett(in-1)-20;
    end
    if isObject==1 && isnan(finett(in))
        [~,finett(in)]=max(trace(finett(in-1)-20:finett(in-1)+20));
        finett(in)=finett(in)+finett(in-1)-20;
    end
    if isObject==1
        d=finett(in-50:in-1);
        d(isnan(d))=[];
        if abs(finett(in)-mean(d))>100
            d1=finett(in-1)-50;
            d2=finett(in-1)+50;
            if d1<1
                d1=1;
            end
            if d2>nz
                d2=nz;
            end
            [~,finett(in)]=max(trace(d1:d2));
            finett(in)=finett(in)+d1;
        end
    end
    rr=var(finett(in-4:in));
    if rr<80
        stableid=stableid+1;
        if stableid>stableTh
            stableid=stableTh;
        end
        isObject=1;
    else
        stableid=stableid-1;
        if stableid<0
            stableid=0;
        end
        isObject=0;
    end
    if stableid==stableTh
        stableid=stableTh;
        plot(in,finett(in),'yo');
    end
    
    
end
hold off
close(gcf);

end
