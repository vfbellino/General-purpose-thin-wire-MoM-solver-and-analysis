% ALGORITHM OF FINDING

doplot = 0;
lamb = 0.6;     lz = 0.5*lamb;      type  = [0,0];      V0 = 1;

%a = 10^(-3)*linspace(0.1,5,100);        I = length(a);
%N = 11:2:2501;                          J = length(N)-1;

% a = 10^(-3)*linspace(0.3,0.5,10);        I = length(a);
% N = 201:50:2101;                          J = length(N)-1;

% a = 3e-4;                                  I = length(a);
% N = 101:2:2001;                          J = length(N)-1;

A = [0.30, 0.35, 0.40, 0.45, 0.50,...
    0.55, 0.60, 0.65, 0.70, 0.75, 0.80, 0.85, 0.90, 0.95, 1.00,...
    1.25, 1.50, 1.75, 2.00, 2.25, 2.50, 2.75, 3.00, 3.25, 3.50,...
    4.00, 4.25, 4.50, 4.75, 5.00];

%A = [0.10];

a = 10^(-3)*A;

I = length(a);

N = 5:2:1901;      J = length(N)-1;

% Obj = @(x,y) x + y;                  OBJ = zeros(I,J);
% idx_ref = zeros(I);

EG = zeros(I,J+1);
EF = zeros(I,J+1);

RANGE_5 = zeros(I,2);     
RANGE_0 = zeros(I,2);
MIN_f = zeros(1,I);
MIN_g = zeros(1,I);

for i = 1:I

    % [~,I0,~,zmid0,feed0] = CURRENT(lamb,lz,a(i),N(1),V0,doplot,type);
    % Icurrent.a(i).N(1).values = I0;
    % Zmid.a(i).N(1).values = zmid0;
    % Feed.a(i).N(1).values = feed0;
    % 
    % for j = 1:J
    %     [~,I1,~,zmid1,feed1] = CURRENT(lamb,lz,a(i),N(j+1),V0,doplot,type);
    %     I_int0 = interp1(zmid0,I0,zmid1,'spline');
    %     eg = norm((I_int0(:)-I1(:)),2)/norm(I1,2);
    %     ef = abs(I_int0(feed1)-I1(feed1))/abs(I1(feed1));
    %     OBJ(i,j) = Obj(eg,ef);
    %     Icurrent.a(i).N(j+1).values = I1;
    %     Zmid.a(i).N(j+1).values = zmid1;
    %     Feed.a(i).N(j+1).values = feed1;
    %     I0 = I1;
    %     zmid0 = zmid1;
    %     feed0 = feed1;
    % end
    % 
    % p = floor(J/10);
    % BEST_idx = zeros(1,10);
    % for h = 1:10
    %     nr = h*p;
    %     [~,c1] = min(OBJ(i,nr:J));
    %     BEST_idx(h) = c1;
    %     BEST_idx(h) = c1 + nr;
    % end
    % 
    % B = length(BEST_idx);
    % 
    % for h = 1:B
    %     lb = BEST_idx(h)-p;
    %     up = BEST_idx(h)+p;
    %     if up>=J
    %         sumOBJ(h) = sum(OBJ(i,lb:end));
    %     else
    %         sumOBJ(h) = sum(OBJ(i,lb:up));
    %     end
    % end
    % 
    % [~,idx_LOW] = min(sumOBJ);
    % best_idx = BEST_idx(idx_LOW);
    % 
    % if best_idx == J
    %     idx_ref(i) = J;
    % elseif best_idx == 1
    %     idx_ref(i) = 1;
    % else
    %     idx_candidate1 = best_idx;
    %     idx_candidate2 = best_idx+1;
    %     no_best1 = OBJ(i,best_idx-1);
    %     no_best2 = OBJ(i,best_idx+1);
    %     if no_best1<=no_best2
    %         idx_ref(i) = best_idx;
    %     else
    %         idx_ref(i) = best_idx+1;
    %     end
    % end

    str = sprintf('dg_%.2f.out.txt', A(i));
    [zmid_ref, I_ref, ~] = readNECcurrent( ...
        str, 0.6);
    nseg_ref = length(zmid_ref);
    feed_ref = (nseg_ref+1)/2;

    % jj = idx_ref(i);
    % I_ref = Icurrent.a(i).N(jj).values;
    % zmid_ref = Zmid.a(i).N(jj).values;
    % feed_ref = Feed.a(i).N(jj).values;

    for j = 1:J+1
        % Ij = Icurrent.a(i).N(j).values;
        % zmidj = Zmid.a(i).N(j).values;
        % feedj = Feed.a(i).N(j).values;
        [~,Ij,~,zmidj,feedj] = ...
            CURRENT(lamb,lz,a(i),N(j),V0,doplot,type);
        if nseg_ref<=N(j)
            I_int = interp1(zmid_ref,I_ref,zmidj,'spline');
            EG(i,j) = norm((I_int(:)-Ij(:)),2)/norm(I_int,2);
            EF(i,j) = abs(I_int(feedj)-Ij(feedj))/abs(I_int(feedj));
        else
            I_int = interp1(zmidj,Ij,zmid_ref,'spline');
            EG(i,j) = norm((I_int(:)-I_ref(:)),2)/norm(I_ref,2);
            EF(i,j) = abs(I_int(feed_ref)-I_ref(feed_ref))/abs(I_ref(feed_ref));
        end

    end

    Deg = -1;
    Def = -1;
    k = 1;

    while Deg<0 || Def<0
        Deg = (EG(i,k+1)-EG(i,k))/(N(k+1)-N(k));
        Def = (EF(i,k+1)-EF(i,k))/(N(k+1)-N(k));
        k = k+1;
        cut_idx = k;
    end

    while Deg>0 || Def>0
        Deg = (EG(i,k+1)-EG(i,k))/(N(k+1)-N(k));
        Def = (EF(i,k+1)-EF(i,k))/(N(k+1)-N(k));
        k = k+1;
        cut_idx = k;
    end

    idx_5g = find(EG(i,cut_idx:end)<=0.05);
    idx_5f = find(EF(i,cut_idx:end)<=0.05);
    idx_5g = cut_idx + idx_5g - 1;
    idx_5f = cut_idx + idx_5f - 1;

    if idx_5g(1)<=idx_5f(1)
        idx5_min = idx_5f(1);
    else
        idx5_min = idx_5g(1);
    end
    if idx_5g(end)<= idx_5f(end)
        idx5_max = idx_5g(end);
    else
        idx5_max = idx_5f(end);
    end

    [min_f,subidx0_min]= min(EF(i,cut_idx:end));
    [min_g,subidx0_max]= min(EG(i,cut_idx:end));
    idx0_min = cut_idx + subidx0_min - 1;
    idx0_max = cut_idx + subidx0_max - 1;

    RANGE_5(i,1) = N(idx5_min);
    RANGE_5(i,2) = N(idx5_max);
    RANGE_0(i,1) = N(idx0_min);
    RANGE_0(i,2) = N(idx0_max);
    MIN_g(i) = min_g;
    MIN_f(i) = min_f;

end


figure(1)

semilogx(a,RANGE_5(:,1),a,RANGE_5(:,2),'LineWidth', 2);
set(gcf, 'Color', 'w');       % Rende bianca l'intera finestra esterna
set(gca, 'Color', 'w');       % Rende bianco il fondo interno del grafico
set(gca, 'XColor', 'k');       % Rende neri i bordi e i numeri dell'asse X (per contrasto)
set(gca, 'YColor', 'k');       % Rende neri i bordi e i numeri dell'asse Y
set(gca, 'ZColor', 'k');       % Rende neri i bordi e i numeri dell'asse Z

xlabel('$a$','Interpreter', 'latex', 'FontSize', 14)
ylabel('$n_{5\%}(a),N_{5\%}(a)$','Interpreter', 'latex', 'Rotation', 0, 'FontSize', 14')
title('Extremes of the agreement interval 5% as functions of the radius'," ",'FontSize',15,'Color', 'k')
legend('n_{5%}','N_{5%}','Color', 'w', 'FontSize', 12,'TextColor', 'k');


figure(2)

semilogx(a,RANGE_0(:,1),a,RANGE_0(:,2),'LineWidth', 2);
set(gcf, 'Color', 'w');       % Rende bianca l'intera finestra esterna
set(gca, 'Color', 'w');       % Rende bianco il fondo interno del grafico
set(gca, 'XColor', 'k');       % Rende neri i bordi e i numeri dell'asse X (per contrasto)
set(gca, 'YColor', 'k');       % Rende neri i bordi e i numeri dell'asse Y
set(gca, 'ZColor', 'k');       % Rende neri i bordi e i numeri dell'asse Z

xlabel('$a$','Interpreter', 'latex', 'FontSize', 14)
ylabel('$n_{0}(a),N_{0}(a)$','Interpreter', 'latex', 'Rotation', 0, 'FontSize', 14')
title('Extremes of the minumum to minimum interval as functions of the radius'," ",'FontSize',15,'Color', 'k')
legend('n_{0}','N_{0}','Color', 'w', 'FontSize', 12,'TextColor', 'k');


figure(3)

semilogx(a,RANGE_0(:,1),a,RANGE_0(:,2),a,RANGE_5(:,1),'b--',a,RANGE_5(:,2),'k--','LineWidth', 2);
set(gcf, 'Color', 'w');       % Rende bianca l'intera finestra esterna
set(gca, 'Color', 'w');       % Rende bianco il fondo interno del grafico
set(gca, 'XColor', 'k');       % Rende neri i bordi e i numeri dell'asse X (per contrasto)
set(gca, 'YColor', 'k');       % Rende neri i bordi e i numeri dell'asse Y
set(gca, 'ZColor', 'k');       % Rende neri i bordi e i numeri dell'asse Z

xlabel('$a$','Interpreter', 'latex', 'FontSize', 14)
ylabel('$n_{0}(a),N_{0}(a)\\n_{5\%}(a),N_{5\%}(a)$','Interpreter', 'latex', 'Rotation', 0, 'FontSize', 14')
title('Extremes as function of the radius'," ",'FontSize',15,'Color', 'k')
legend('n_{0}','N_{0}','n_{5%}','N_{5%}','Color', 'w', 'FontSize', 12,'TextColor', 'k');


x_5 = log(a);

y_5 = log(RANGE_5(:,1));
Y_5 = log(RANGE_5(:,2));
p_xy5 = polyfit(x_5,y_5,1);
p_xY5 = polyfit(x_5,Y_5,1);

alpha_xy5 = -p_xy5(1);
alpha_xY5 = -p_xY5(1);
C_xy5 = exp(p_xy5(2));
C_xY5 = exp(p_xY5(2));


x_0 = log(a);

y_0 = log(RANGE_0(:,1));
Y_0 = log(RANGE_0(:,2));
p_xy0 = polyfit(x_0,y_0,1);
p_xY0 = polyfit(x_0,Y_0,1);

alpha_xy0 = -p_xy0(1);
alpha_xY0 = -p_xY0(1);
C_xy0 = exp(p_xy0(2));
C_xY0 = exp(p_xY0(2));