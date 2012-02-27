
load('data/smap.mat')
stemmedSmap = cellfun(@(x) porterStemmer(x), smap, 'UniformOutput', false);
[smapUnique, uniqToSmap, smapToUniq] = unique(stemmedSmap, 'first');
save('data/stemmedSmap.mat', 'smapUnique', 'uniqToSmap',...
     'smapToUniq', 'stemmedSmap')

