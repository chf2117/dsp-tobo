function [ y ] = mytranspose(x, fs, st)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    justmap = [[16,15],[9,8],[6,5],[5,4]];
    n = 2^nextpow2(1024*fs/16000);
    r = 2^(st/12);
    x2 = pvoc(x,1/r,n);
    y = resample(x2,1000,floor(1000*r));
end

