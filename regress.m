% Sentiment Scorer with Linear Regression

% This is tokenized data from the Multi-Domain Sentiment Dataset found at:
% http://www.cs.jhu.edu/~mdredze/datasets/sentiment/
% The mat file contains three variables:
% - tokens
% - scnt
% - smap
%load('data/tokenized.mat')

load('data/tokens.mat', 'tokens');
load('data/scnt.mat', 'scnt');
load('data/smap.mat', 'smap');

load('data/stopwords.mat', 'stopWordIndexes');
load('data/stemmedSmap.mat', 'smapUnique', 'uniqToSmap',...
     'smapToUniq', 'stemmedSmap');

dictSize = length(smap)

% tokens is a 3xN matrix, but the first two rows are useless.
% Get rid of the first two rows.
% This should reduce the amount of memory required significantly.
tokens = tokens(3, :);

% Find the token index for the common tokens.
%TOKEN_REVIEW_BEGIN = strmatch('<review>', smap, 'exact');
%TOKEN_REVIEW_END = strmatch('</review>', smap, 'exact');
TOKEN_RATING_BEGIN = strmatch('<rating>', smap, 'exact');
%TOKEN_RATING_END = strmatch('</rating>', smap, 'exact');
TOKEN_REVIEW_TEXT_BEGIN = strmatch('<review_text>', smap, 'exact');
TOKEN_REVIEW_TEXT_END = strmatch('</review_text>', smap, 'exact');

% Extract rating positions and find the total number of reviews.
reviewTextBeginPositions = find(tokens == TOKEN_REVIEW_TEXT_BEGIN);
reviewTextEndPositions = find(tokens == TOKEN_REVIEW_TEXT_END);
numReviews = length(reviewTextBeginPositions);

Xdefault = sparse(1 + dictSize, numReviews);
XnoStopWord = sparse(1 + dictSize, numReviews);
Xstemmed = sparse(1 + dictSize, numReviews);

map = containers.Map('KeyType', 'char', 'ValueType', 'logical');
uniqueReviews = logical([]);

for i = 1 : numReviews
    
    % report progress
    if mod(i, 10000) == 0
        i
        length(uniqueReviews)
    end
    
    reviewTexts = tokens(reviewTextBeginPositions(i) : ...
                         reviewTextEndPositions(i));
    
    % skip the review if it has been observed before.
    hashkey = mat2str(reviewTexts(1 : min(10, end)));
    if ~isKey(map, hashkey)
        map(hashkey) = true;
        uniqueReviews = [uniqueReviews; i];
        
        % stop words
        reviewStopWords = double(setdiff(reviewTexts, stopWordIndexes));
        
        % stemming
        textLen = length(reviewTexts);
        reviewStemmed = ones(textLen);
        for j = 1 : textLen
            reviewStemmed(j) = smapToUniq(reviewTexts(j));
        end
        
        Xdefault(:, i) = [1; sparse(double(reviewTexts), 1, 1, ...
            dictSize, 1)];
        Xstemmed(:, i) = [1; sparse(double(reviewStemmed), 1, 1, ...
            dictSize, 1)];
        Xstopwords(:, i) = [1; sparse(double(reviewStopWords), 1, 1, ...
            dictSize, 1)];
    end
end

display('uniqueReviews: ')
display(length(uniqueReviews))

% process y.
% Extract ratings (assume all ratings are integers).
ratingPositions = find(tokens == TOKEN_RATING_BEGIN);
y = cell2mat(smap(tokens(ratingPositions + 1))) - '0';
yuniq = y(uniqueReviews);


Xuniq = Xdefault(:, uniqueReviews);
save('data/model-default.mat', 'Xuniq', 'yuniq');

Xuniq = Xstemmed(:, uniqueReviews);
save('data/model-stemmed.mat', 'Xuniq', 'yuniq');

Xuniq = Xstopwords(:, uniqueReviews);
save('data/model-stopwords.mat', 'Xuniq', 'yuniq');




