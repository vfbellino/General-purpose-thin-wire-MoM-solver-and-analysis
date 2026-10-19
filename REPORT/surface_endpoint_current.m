lamb = 0.6;
lz = 0.5*lamb;
V0 = 1;
%type  = [0,0];

a = 10^(-3)*linspace(0.1,5,100);
nseg = 101:10:701;

for n = 1:length(nseg)
    for k = 1:length(a)
        type = [1,sqrt(1.1)*a(k)];
        [~,I,~,~,feed] = CURRENT(lamb,lz,a(k),nseg(n),V0,0,type);
        I1(n,k) = I(1);
    end
end

[N,A] = meshgrid(a,nseg);

% figure(1)
% 
% surf(N,A,1000*abs(I1));
% 
% % --- 2. Etichette degli assi ---
% xlabel('$a$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% ylabel('$N$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% zlabel('$|I_{endpoint}|$ mA', 'Interpreter', 'latex', 'Rotation', 0, 'FontSize', 12, 'FontWeight', 'bold')
% set(gcf, 'Color', 'w');       % Rende bianca l'intera finestra esterna
% set(gca, 'Color', 'w');       % Rende bianco il fondo interno del grafico
% set(gca, 'XColor', 'k');       % Rende neri i bordi e i numeri dell'asse X (per contrasto)
% set(gca, 'YColor', 'k');       % Rende neri i bordi e i numeri dell'asse Y
% set(gca, 'ZColor', 'k');       % Rende neri i bordi e i numeri dell'asse Z
% % --- 3. Titolo del grafico ---
% title('Surface representing $|I_{endpoint}|$ as a function of $N$ and $a$'," ", 'Interpreter', 'latex', 'Color', 'k', 'FontSize', 14)
% 
% % cb = colorbar;               % Mostra la barra laterale
% % ylabel(cb, 'Scala Valori Ifeed') % Aggiunge un'etichetta alla barra stessa
% 
% % --- 5. Opzioni Estetiche Consigliate ---
% 
% colormap jet                 % Cambia la mappa dei colori (es. 'jet', 'parula', 'hot')
% grid on                      % Attiva la griglia di sfondo


livelli = logspace(-3, 3, 15);

figure(2)
contour(N, A, 1000*abs(I1), livelli, 'LineWidth', 2)
title('Level curve of the surface $|I_{endpoint}|$ as a function of $N$ and $a$'," ", 'Interpreter', 'latex', 'Color', 'k', 'FontSize', 14)
xlabel('$a$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
ylabel('$N$', 'Interpreter', 'latex', 'Rotation', 0, 'FontSize', 12, 'FontWeight', 'bold')
set(gcf, 'Color', 'w');       % Rende bianca l'intera finestra esterna
set(gca, 'Color', 'w');       % Rende bianco il fondo interno del grafico
set(gca, 'XColor', 'k');       % Rende neri i bordi e i numeri dell'asse X (per contrasto)
set(gca, 'YColor', 'k');       % Rende neri i bordi e i numeri dell'asse Y
set(gca, 'ZColor', 'k');       % Rende neri i bordi e i numeri dell'asse Z