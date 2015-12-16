function [ y,fs ] = example(filename,T, st)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    [x,fs] = audioread(filename);
    [xp,xt,~] = percussion(x,fs,T);
    y = mytranspose(xt,fs,st);
    xp = xp(1:numel(y));
    y = y + xp';
end