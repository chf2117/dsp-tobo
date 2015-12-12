[d,sr]=audioread('excerpt.wav'); 
e = pvoc(d, 0.8); 
f = resample(e,4,5); % NB: 0.8 = 4/5 
soundsc(f,sr)