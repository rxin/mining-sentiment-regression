load('data/tokenized.mat')
display('finished loading tokenized.mat')

save('-v7.3', 'tokens.mat', 'tokens')
display('finished saving tokens.mat')

save('data/scnt.mat', 'scnt')
display('finished saving scnt.mat')

save('data/smap.mat', 'smap')
display('finished saving smap.mat')
