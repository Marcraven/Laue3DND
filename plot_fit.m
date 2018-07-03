function  plot_fit(G,q,removed1,removed2,reflections1,reflections2)

figure(1);
title('Backdiffraction fits')
subplot(ceil(sqrt(G.ngrains)),ceil(sqrt(G.ngrains)),q);
hold on
scatter3(reflections1(:,2),reflections1(:,3),reflections1(:,4),2);
scatter3(removed1(:,1),removed1(:,2),removed1(:,3),2);
view([90 0]);
figure(2);
title('Transmission fits')
subplot(ceil(sqrt(G.ngrains)),ceil(sqrt(G.ngrains)),q);
hold on
scatter3(reflections2(:,2),reflections2(:,3),reflections2(:,4),2);
scatter3(removed2(:,1),removed2(:,2),removed2(:,3),2);
view([90 0]);
figure(3);
subplot(ceil(sqrt(G.ngrains)),ceil(sqrt(G.ngrains)),q);
histogram(reflections1(:,7),'BinWidth',0.25);
figure(4);
subplot(ceil(sqrt(G.ngrains)),ceil(sqrt(G.ngrains)),q);
histogram(reflections2(:,7),'BinWidth',0.25);



end

