function plotLIFT(deff, stopf, stemf)

load('AUC')

ks=1000:2000:11000;
lambdas=5:350:1500;

f1 = figure();
%plot(ks, dLIFT(3,:), lambdas, sLIFT(3,:), lambdas, rLIFT(3,:))
plot(ks, dAUC(:,3), ks, sAUC(:,3), ks, rAUC(:,3))
hleg1 = legend('Default','Stem', 'Stop');

xlabel('k', 'FontWeight', 'bold', 'FontSize', 20);
%xlabel('\lambda', 'FontWeight', 'bold', 'FontSize', 20);
ylabel('1% lift', 'FontWeight', 'bold', 'FontSize', 20);

print(f1, '-dpdf', 'lift.pdf');            
