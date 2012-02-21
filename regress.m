% Sentiment Scorer with Linear Regression

% This is tokenized data from the Multi-Domain Sentiment Dataset found at:
% http://www.cs.jhu.edu/~mdredze/datasets/sentiment/
load('data/tokenized.mat')

% tokens is a 3xN matrix, but the first two rows are useless.
% Get rid of the first two rows.
tokens = tokens(3, :)

% Find the token index for the common tokens.
%TOKEN_REVIEW_BEGIN = strmatch('<review>', smap, 'exact')
%TOKEN_REVIEW_END = strmatch('</review>', smap, 'exact')
TOKEN_RATING_BEGIN = strmatch('<rating>', smap, 'exact')
%TOKEN_RATING_END = strmatch('</rating>', smap, 'exact')
TOKEN_REVIEW_TEXT_BEGIN = strmatch('<review_text>', smap, 'exact')
TOKEN_REVIEW_TEXT_END = strmatch('</review_text>', smap, 'exact')

% Extract ratings (assume all ratings are integers).
ratingPositions = find(tokens == TOKEN_RATING_BEGIN)
y = cell2mat(smap(tokens(ratingPositions + 1))) - '0'

% Extract rating positions and find the total number of reviews.
reviewTextBeginPositions = find(tokens == TOKEN_REVIEW_TEXT_BEGIN)
reviewTextEndPositions = find(tokens == TOKEN_REVIEW_TEXT_END)
numReviews = size(y)
numReviews = numReviews(1)

X = sparse(1 + size(smap), numReviews)

for i = 1 : numReviews
    reviewTexts = tokens(reviewTextBeginPositions(i), ...
                         reviewTextEndPositions(i))
    
    % to be continued...
end