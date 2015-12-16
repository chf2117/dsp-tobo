function [xp,xt,fs] = percussion(x,fs,T)
    x = x(:,1); % If stereo, just take one side
    
    p = nextpow2(numel(x)/700);
    window = 2^p;
    noverlap = (2^p)/2;
    nfft = 2^p;
    s1 = spectrogram(x(:,1),window,noverlap,nfft,fs);

    DF = beats(T,s1);

    xp = zeros(1,numel(x)); % initialize vector of percussive components
    xt = zeros(1,numel(x)); % initialize vector of tonal components

    for i=1:numel(DF)
        if DF(i) == 1
            if (i+3)*noverlap<=numel(x)
                xp(i*noverlap:(i+3)*noverlap) = x(i*noverlap:(i+3)*noverlap);
            elseif (i+2)*noverlap<=numel(x)
                xp(i*noverlap:(i+2)*noverlap) = x(i*noverlap:(i+2)*noverlap);
            elseif (i+1)*noverlap<=numel(x)
                xp(i*noverlap:(i+1)*noverlap) = x(i*noverlap:(i+1)*noverlap);
            else
                xp(i*noverlap) = x(i*noverlap);
            end
        end
    end
    xt = x-transpose(xp);
    
% function 'beats' returns a vector of 1's and 0's. The 1's are locations
% with percussive elements
function [ DF ] = beats(T,s)
DF = zeros(1,numel(s(1,:)));
for m = 2:numel(s(1,:)) 
    dmksum = 0;
    for k = 1:numel(s(:,1))
        dmk = log2(abs(s(k,m))/abs(s(k,m-1)));
        dmksum = max(dmk,0)+dmksum;
    end
    if dmksum>T
        DF(m) = 1;
    end
end

