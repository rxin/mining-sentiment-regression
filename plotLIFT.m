function plotROC(deff, stopf, stemf)

load(LIFT)

ks=1000:2000:11000;
lambdas=5:350:1500;

f1 = figure();
             
plot(lambdas, dLIFT(1,:), sLIFT(1,:), rLIFT(1,:))
hleg1 = legend('Default','Stem', 'Stop');

xlabel('false positive rate(%)', 'FontWeight', 'bold', 'FontSize', 20);
ylabel('true positive rate(%)', 'FontWeight', 'bold', 'FontSize', 20);

print(f1, '-dpdf', 'hehe.pdf');
