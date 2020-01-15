function  plot2l(l1,l2)
    plot(l1,'r','LineWidth',2)
    hold on
    plot(l2,'b','LineWidth',2)
    hold off
    legend('Line 1','Line 2');
    set(gcf,'Color',[1,1,1]);
    grid on
end

