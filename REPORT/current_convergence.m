% CURRENT CONVERGENCE

lamb = 0.6;
lz = 0.5*lamb;
a = 3e-3;

%type = [1,sqrt(1.1)*a];
type  = [0,0];

V0 = 1;

% nseg = [401,421];
% leg = strings(1,length(nseg));
% 
% for n = 1:length(nseg)
%     [~,I,i0,zmid,feed] = CURRENT(lamb,lz,a,nseg(n),V0,0,type);
%     IWire(n).current = I;
%     IWire(n).zmid = zmid;
% end


% figure(1)
% for i = 1:length(nseg)
%     title('Magnetic frill model current: radius 0.3 mm'," ",'FontSize',15,'Color', 'k')
%     xlabel('$z\over L$','Interpreter', 'latex', 'FontSize', 14)
%     ylabel('$\biggl|I\biggl({z\over L}\biggr)\biggr|\;{\rm mA}$','Interpreter', 'latex', 'Rotation', 0,'FontSize', 14)
%     leg(i) = sprintf('N = %i',nseg(i));
%     p(n) = plot(IWire(i).zmid/lz,1000*abs(IWire(i).current),'LineWidth', 2);
%     hold on
% end
%     legend(leg,'Color', 'w', 'FontSize', 12,'TextColor', 'k');

a = 10^(-3)*linspace(0.1,5,100);
nseg = [101,401,501,601,701];
leg = strings(1,length(nseg));
V0 = 1;

% figure(2)
% for n = 1:length(nseg)
%     for m = 1:length(a)
%     [~,I,i0,zmid,feed] = CURRENT(lamb,lz,a(m),nseg(n),V0,0,type);
%     IWire(n).feed(m) = abs(I(feed));
%     end
%     title('Delta gap: sweep of the feed current'," ",'FontSize',15,'Color', 'k')
%     xlabel('$a\over L$','Interpreter', 'latex', 'FontSize', 14)
%     ylabel('$\biggl|I_{feed}\biggr|\;{\rm mA}$','Interpreter', 'latex', 'Rotation', 0,'FontSize', 14)
    % set(gcf, 'Color', 'w');       % Rende bianca l'intera finestra esterna
    % set(gca, 'Color', 'w');       % Rende bianco il fondo interno del grafico
    % set(gca, 'XColor', 'k');       % Rende neri i bordi e i numeri dell'asse X (per contrasto)
    % set(gca, 'YColor', 'k');       % Rende neri i bordi e i numeri dell'asse Y
    % set(gca, 'ZColor', 'k');       % Rende neri i bordi e i numeri dell'asse Z
%     q(n) = loglog(a/lz,1000*IWire(n).feed(:),'LineWidth', 2);
%     hold on
%     leg(n) = sprintf('N = %i',nseg(n));
% end
%     legend(leg,'Color', 'w', 'FontSize', 12,'TextColor', 'k');

    % figure(2)
    % for n = 1:length(nseg)
    %     for m = 1:length(a)
    %         type = [1,sqrt(1.1)*a(m)];
    %         [~,I,~,~,~] = CURRENT(lamb,lz,a(m),nseg(n),V0,0,type);
    %         IWire(n).edge(m) = abs(I(1));
    %     end
    %     title('Magnetic frill: sweep of the endpoint current'," ",'FontSize',15,'Color', 'k')
    %     xlabel('$a\over L$','Interpreter', 'latex', 'FontSize', 14)
    %     ylabel('$\biggl|I_{endpoint}\biggr|\;{\rm mA}$','Interpreter', 'latex', 'Rotation', 0,'FontSize', 14)
        % set(gcf, 'Color', 'w');       % Rende bianca l'intera finestra esterna
        % set(gca, 'Color', 'w');       % Rende bianco il fondo interno del grafico
        % set(gca, 'XColor', 'k');       % Rende neri i bordi e i numeri dell'asse X (per contrasto)
        % set(gca, 'YColor', 'k');       % Rende neri i bordi e i numeri dell'asse Y
        % set(gca, 'ZColor', 'k');       % Rende neri i bordi e i numeri dell'asse Z
    %     q(n) = loglog(a/lz,1000*IWire(n).edge(:),'LineWidth', 2);
    %     hold on
    %     leg(n) = sprintf('N = %i',nseg(n));
    % end
    % legend(leg,'Color', 'w', 'FontSize', 12,'TextColor', 'k');

% nseg = 151:50:801;
% 
% for n = 1:length(nseg)
%     for m = 1:length(a)
%         [~,I,i0,zmid,feed] = CURRENT(lamb,lz,a(m),nseg(n),V0,0,type);
%         IWire(n).feed(m) = abs(I(feed));
%     end
%         [~,idx(n)] = min(abs(0.014-abs(IWire(n).feed(:))));
% end
% 
% figure(3)
% plot(nseg,a(idx),'LineWidth', 2)
% title('Breakdown radius: Value of a at abs(I(0))=14mA'," ",'FontSize',15,'Color', 'k')
% xlabel('$N$','Interpreter', 'latex', 'FontSize', 14)
% ylabel("$a_{break}$",'Interpreter', 'latex', 'Rotation', 0,'FontSize', 14)

nseg = 501:30:801;

for n = 1:length(nseg)
    for m = 1:length(a)
        type = [1,sqrt(1.1)*a(m)];
        [~,I,i0,zmid,feed] = CURRENT(lamb,lz,a(m),nseg(n),V0,0,type);
        IWire(n).edge(m) = abs(I(1));
    end
    [~,idx(n)] = min(abs(0.001-abs(IWire(n).edge(:))));
end
% 
% figure(3)
% plot(nseg,a(idx),'LineWidth', 2)
% title('Breakdown radius: Value of a at abs(I(-L/2))=0.35mA'," ",'FontSize',15,'Color', 'k')
% xlabel('$N$','Interpreter', 'latex', 'FontSize', 14)
% ylabel("$a_{break}$",'Interpreter', 'latex', 'Rotation', 0,'FontSize', 14)


% figure(4)
% plot(nseg,nseg.^2.*a(idx)/lz^2,'LineWidth', 2)
% title('Breakdown radius: Value of a/Dz^2 at abs(I(0))=14mA'," ",'FontSize',15,'Color', 'k')
% xlabel('$N$','Interpreter', 'latex', 'FontSize', 14)
% ylabel("$a\over \Delta z^2$",'Interpreter', 'latex', 'Rotation', 0,'FontSize', 14)
% 

% nseg = nseg(:);
% a_break = a(idx);
% 
% x = log(nseg);
% y = log(a_break);
% 
% p = polyfit(x, y, 1);
% 
% alpha = -p(1);
% C = exp(p(2));
% 
% a_fit = C * nseg.^(-alpha);
% 
% y_fit = polyval(p, x);
% R2 = 1 - sum((y-y_fit).^2) / sum((y-mean(y)).^2);
% 
% fprintf('alpha = %.6f\n', alpha);
% fprintf('C = %.6e m\n', C);
% fprintf('R^2 logaritmico = %.6f\n', R2);
% 
% figure(5);
% loglog(nseg, a_break, 'bo', 'MarkerSize', 7);
% title('Experimental law vs Fit'," ",'FontSize',15,'Color', 'k')
% hold on;
% N_cont = linspace(min(nseg), max(nseg), 500);
% loglog(N_cont, C*N_cont.^(-alpha), ...
%     'r-', 'LineWidth', 1.5);
% xlabel('$N$','Interpreter', 'latex', 'FontSize', 14)
% ylabel("$a_{break}$",'Interpreter', 'latex', 'Rotation', 0,'FontSize', 14)
% set(gcf, 'Color', 'w');       % Rende bianca l'intera finestra esterna
% set(gca, 'Color', 'w');       % Rende bianco il fondo interno del grafico
% set(gca, 'XColor', 'k');       % Rende neri i bordi e i numeri dell'asse X (per contrasto)
% set(gca, 'YColor', 'k');       % Rende neri i bordi e i numeri dell'asse Y
% set(gca, 'ZColor', 'k');       % Rende neri i bordi e i numeri dell'asse Z
% legend('Numerical data', ...
%     sprintf('Power-law fit: \\alpha = %.4f', alpha), ...
%     'Location', 'best');
% % legend.Color = 'k';       
% % legend.TextColor = 'k';   
% % legend.EdgeColor = 'w';   
% grid on;

% plot(nseg,nseg.^2.*a(idx)/lz^2,'LineWidth', 2)
% title('Breakdown radius: Value of a/Dz^2 at abs(I(0))=14mA'," ",'FontSize',15,'Color', 'k')
% xlabel('$N$','Interpreter', 'latex', 'FontSize', 14)
% ylabel("$a\over \Delta z^2$",'Interpreter', 'latex', 'Rotation', 0,'FontSize', 14)
% 
% 

nseg = nseg(:);
a_break = a(idx);

x = log(nseg);
y = log(a_break);

p = polyfit(x, y, 1);

alpha = -p(1);
C = exp(p(2));

a_fit = C * nseg.^(-alpha);

y_fit = polyval(p, x);
R2 = 1 - sum((y-y_fit).^2) / sum((y-mean(y)).^2);

fprintf('alpha = %.6f\n', alpha);
fprintf('C = %.6e m\n', C);
fprintf('R^2 logaritmico = %.6f\n', R2);

figure(5);
loglog(nseg, a_break, 'bo', 'MarkerSize', 7);
title('Experimental law vs Fit'," ",'FontSize',15,'Color', 'k')
hold on;
N_cont = linspace(min(nseg), max(nseg), 500);
loglog(N_cont, C*N_cont.^(-alpha), ...
    'r-', 'LineWidth', 1.5);
xlabel('$N$','Interpreter', 'latex', 'FontSize', 14)
ylabel("$a_{break}$",'Interpreter', 'latex', 'Rotation', 0,'FontSize', 14)
set(gcf, 'Color', 'w');       % Rende bianca l'intera finestra esterna
set(gca, 'Color', 'w');       % Rende bianco il fondo interno del grafico
set(gca, 'XColor', 'k');       % Rende neri i bordi e i numeri dell'asse X (per contrasto)
set(gca, 'YColor', 'k');       % Rende neri i bordi e i numeri dell'asse Y
set(gca, 'ZColor', 'k');       % Rende neri i bordi e i numeri dell'asse Z
% legend('Numerical data', ...
%     sprintf('Power-law fit: \\alpha = %.4f', alpha), ...
%     'Location', 'best');
% legend.Color = 'k';       
% legend.TextColor = 'k';   
% legend.EdgeColor = 'w';   
% grid on;

% plot(nseg,nseg.^2.*a(idx)/lz^2,'LineWidth', 2)
% title('Breakdown radius: Value of a/Dz^2 at abs(I(0))=14mA'," ",'FontSize',15,'Color', 'k')
% xlabel('$N$','Interpreter', 'latex', 'FontSize', 14)
% ylabel("$a\over \Delta z^2$",'Interpreter', 'latex', 'Rotation', 0,'FontSize', 14)
% 
