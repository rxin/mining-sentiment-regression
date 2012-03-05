function plotROC(deff, stopf, stemf)

load(deff)
load(stemf)
load(stopf)

f1 = figure();

plot(dx, dy, sx, sy, rx, ry)
hleg1 = legend('Default','Stem', 'Stop');

xlabel('false positive rate(%)', 'FontWeight', 'bold', 'FontSize', 20);
ylabel('true positive rate(%)', 'FontWeight', 'bold', 'FontSize', 20);

print(f1, '-dpdf', 'hehe.pdf');

