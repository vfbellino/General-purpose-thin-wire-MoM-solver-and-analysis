% % N = 271:100:401;
% N = 51:20:111;
% % N = [51,81];
% leg = strings(1,length(N));
% 
% for i = 1:length(N)
% str = sprintf('dg_3_%.2i.out.txt', N(i));
% [zNEC, INEC, data] = readNECcurrent( ...
%     str, 0.6);
% 
% figure (1)
% hold on
% plot(zNEC/0.3, abs(INEC)*1e3, '-', ...
%     'LineWidth', 1.5)
% set(gcf, 'Color', 'w');       % Rende bianca l'intera finestra esterna
% set(gca, 'Color', 'w');       % Rende bianco il fondo interno del grafico
% set(gca, 'XColor', 'k');       % Rende neri i bordi e i numeri dell'asse X (per contrasto)
% set(gca, 'YColor', 'k');       % Rende neri i bordi e i numeri dell'asse Y
% set(gca, 'ZColor', 'k');       % Rende neri i bordi e i numeri dell'asse Z
% 
% xlabel('$z\over L$','Interpreter', 'latex', 'FontSize', 14)
% ylabel('$\biggl|I\biggl({z\over L}\biggr)\biggr|\;{\rm mA}$','Interpreter', 'latex', 'Rotation', 0, 'FontSize', 14')
% title('NEC2 current distribution for a = 3 mm'," ",'FontSize',15,'Color', 'k')
% leg(i) = sprintf('N = %i',N(i));
% end
% legend(leg,'Color', 'w', 'FontSize', 12,'TextColor', 'k');

[zNEC_EX, INEC_EX, data] = readNECcurrent( ...
    'dg_3_51.out.txt', 0.6);
[zNEC_EX2, INEC_EX2, data] = readNECcurrent( ...
    'dg_3_101.out.txt', 0.6);

Iint1 = interp1(zNEC_EX, INEC_EX, zNEC_EX2, 'spline');
epsilon_g_comp = norm((Iint1(:)-INEC_EX2(:)),2)/norm(Iint1,2);
epsilon_f_comp = abs(Iint1(51)-INEC_EX2(51))/abs(Iint1(51));

lamb = 0.6;
lz = 0.5*lamb;
a = 3e-3;

%type = [1,sqrt(1.1)*a];
type  = [0,0];

V0 = 1;

% nseg = 51:20:121;
% leg = strings(1,length(nseg)+1);
% 
% for n = 1:length(nseg)
%     [~,I,i0,zmid,feed] = CURRENT(lamb,lz,a,nseg(n),V0,0,type);
%     IWire(n).current = I;
%     IWire(n).zmid = zmid;
% end
% 
% figure(1)
% for i = 1:length(nseg)
%     title('Delta-gap MoM VS NEC: radius 3 mm'," ",'FontSize',15,'Color', 'k')
%     set(gcf, 'Color', 'w');       % Rende bianca l'intera finestra esterna
%     set(gca, 'Color', 'w');       % Rende bianco il fondo interno del grafico
%     set(gca, 'XColor', 'k');       % Rende neri i bordi e i numeri dell'asse X (per contrasto)
%     set(gca, 'YColor', 'k');       % Rende neri i bordi e i numeri dell'asse Y
%     set(gca, 'ZColor', 'k');       % Rende neri i bordi e i numeri dell'asse Z
%     xlabel('$z\over L$','Interpreter', 'latex', 'FontSize', 14)
%     ylabel('$\Im\biggl(I\biggl({z\over L}\biggr)\biggr)\;{\rm mA}$','Interpreter', 'latex', 'Rotation', 0,'FontSize', 14)
%     leg(i) = sprintf('N = %i',nseg(i));
%     p(n) = plot(IWire(i).zmid/lz,1000*imag(IWire(i).current),'--','LineWidth', 2);
%     hold on
% end
%     leg(end) = sprintf('NEC');
%     plot(zNEC_EX/0.3, imag(INEC_EX)*1e3, '-', 'LineWidth', 1, 'Color', 'k');
%     legend(leg,'Color', 'w', 'FontSize', 12,'TextColor', 'k');


nseg = 63:2:83;

for i = 1:length(nseg)
    [~,I,i0,zmid,feed] = CURRENT(lamb,lz,a,nseg(i),V0,0,type);
    Iint = interp1(zNEC_EX, INEC_EX, zmid, 'spline');
    epsilon_g(i) = norm((Iint(:)-I(:)),2)/norm(Iint,2);
    epsilon_f(i) = abs(I(feed)-Iint(feed))/abs(Iint(feed));
end

idx_g_1 = find(epsilon_g(:)<=0.01);
idx_g_5 = find(epsilon_g(:)<=0.05);
idx_f_1 = find(epsilon_f(:)<=0.01);
idx_f_5 = find(epsilon_f(:)<=0.05);

N_g_1 = nseg(idx_g_1);
N_g_5 = nseg(idx_g_5);
N_f_1 = nseg(idx_f_1);
N_f_5 = nseg(idx_f_5);

[min_l2,idx_min_l2] = min(epsilon_g);
[min_f,idx_min_f] = min(epsilon_f);

N_g_min = nseg(idx_min_l2);
N_f_min = nseg(idx_min_f);


plot(nseg,epsilon_g,'-', 'LineWidth', 2);
    title('Relative errors: L2 and feed local'," ", 'Fontsize', 15,'Color', 'k')
    set(gcf, 'Color', 'w');       % Rende bianca l'intera finestra esterna
    set(gca, 'Color', 'w');       % Rende bianco il fondo interno del grafico
    set(gca, 'XColor', 'k');       % Rende neri i bordi e i numeri dell'asse X (per contrasto)
    set(gca, 'YColor', 'k');       % Rende neri i bordi e i numeri dell'asse Y
    xlabel('$N$','Interpreter', 'latex', 'FontSize', 14)
    ylabel('$\epsilon_{\ell^2},\;\epsilon_{feed}$','Interpreter', 'latex', 'Rotation', 0,'FontSize', 14)
hold on
plot(nseg,epsilon_f,'-', 'LineWidth', 2);
legend('L2','feed','Color', 'w', 'FontSize', 12,'TextColor', 'k');