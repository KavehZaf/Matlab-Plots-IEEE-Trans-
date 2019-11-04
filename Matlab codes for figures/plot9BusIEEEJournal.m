load ('9BusmatpowercaseV7_BEHINEH_04_11_2019.mat');
mpc = get_mpc(om);

[baseMVA, num_var, Hor_Sim, gencost ] = ...
    deal(mpc.baseMVA, ...
    mpc.num_var, mpc.Hor_Sim, mpc.gencost);


vv = get_idx(om);


    State_ofC1 = zeros(1,length(x_new)/num_var);
    State_ofC2 = zeros(1,length(x_new)/num_var);
    State_ofC3 = zeros(1,length(x_new)/num_var);
    gen1      = zeros(1,length(x_new)/num_var);
    gen2      = zeros(1,length(x_new)/num_var);
    gen3      = zeros(1,length(x_new)/num_var);
    charge1    = zeros(1,length(x_new)/num_var);
    discharge1 = zeros(1,length(x_new)/num_var);
    charge2    = zeros(1,length(x_new)/num_var);
    discharge2 = zeros(1,length(x_new)/num_var);
    charge3    = zeros(1,length(x_new)/num_var);
    discharge3 = zeros(1,length(x_new)/num_var);
    Ploa1     = zeros(1,length(x_new)/num_var);
    Ploa2     = zeros(1,length(x_new)/num_var);
    Ploa3     = zeros(1,length(x_new)/num_var);
    for i=1:Hor_Sim
        iVa    = vv.i1.Va+(i-1)*num_var:vv.iN.Va+(i-1)*num_var;
        iVm    = vv.i1.Vm+(i-1)*num_var:vv.iN.Vm+(i-1)*num_var;
        iPg    = vv.i1.Pg+(i-1)*num_var:vv.iN.Pg+(i-1)*num_var;
        iQg    = vv.i1.Qg+(i-1)*num_var:vv.iN.Qg+(i-1)*num_var;
        iSOC   = vv.i1.SOC+(i-1)*num_var:vv.iN.SOC+(i-1)*num_var;
        iPCH   = vv.i1.PCH+(i-1)*num_var:vv.iN.PCH+(i-1)*num_var;
        iPDICH = vv.i1.PDICH+(i-1)*num_var:vv.iN.PDICH+(i-1)*num_var;
        ivar   = [iVa iVm iPg iQg iSOC iPCH iPDICH];
        State_ofC1(i)= x_new(iSOC(1))*baseMVA;
        State_ofC2(i)= x_new(iSOC(2))*baseMVA;
        State_ofC3(i)= x_new(iSOC(3))*baseMVA;
        gen1(i)=x_new(iPg(1))*baseMVA;
        gen2(i)=x_new(iPg(2))*baseMVA;
        gen3(i)=x_new(iPg(3))*baseMVA;
        charge1(i)=x_new(iPCH(1))*baseMVA;
        charge2(i)=x_new(iPCH(2))*baseMVA;
        charge3(i)=x_new(iPCH(3))*baseMVA;
        discharge1(i)=x_new(iPDICH(1))*baseMVA;
        discharge2(i)=x_new(iPDICH(2))*baseMVA;
        discharge3(i)=x_new(iPDICH(3))*baseMVA;
        Ploa1(i)=mpc.Pd(5,i);
        Ploa2(i)=mpc.Pd(7,i);
        Ploa3(i)=mpc.Pd(9,i);
    end
    Ploat=sum([Ploa1; Ploa2 ; Ploa3]);
    gen=sum([gen1; gen2 ; gen3]);
    hold on
    xaxes=1:Hor_Sim;
%     plot(xaxes,State_ofC1,'LineWidth',1.5);
%     plot(xaxes,State_ofC2,'LineWidth',1.5);
%     plot(xaxes,State_ofC3,'LineWidth',1.5);
%     plot(xaxes,gen);
% %     plot(xaxes,charge1,'LineWidth',1.5);
%     plot(xaxes,discharge1,'LineWidth',1.5);
% %     plot(xaxes,charge2,'LineWidth',1.5);
%     plot(xaxes,discharge2,'LineWidth',1.5);
% %     plot(xaxes,charge3,'LineWidth',1.5);
%     plot(xaxes,discharge3,'LineWidth',1.5);
%     plot(xaxes,Ploa1);
%     plot(xaxes,Ploa2);
%     plot(xaxes,Ploa3);
%     plot(xaxes,Ploat,'LineWidth',1.5);


% plot(xaxes,Ploa1);
% p12=stairs(0:Hor_Sim,[Ploa1 Ploa1(:,end)],...
%        'linewidth', 1,'Marker','o');
   hold on

% % plot(xaxes,Ploa2);
pd=stairs(0:Hor_Sim,[Ploat Ploat(:,end)],...
       'linewidth', 1.5,'Marker','s');
% plot(xaxes,Ploa3);
pg=stairs(0:Hor_Sim,[gen gen(:,end)],...
       'linewidth', 1.5,'Marker','*');
% plot(xaxes,Ploat,'LineWidth',1.5);
psoc1=stairs(0:Hor_Sim,[State_ofC1 State_ofC1(:,end)],...
       'linewidth', 1.5,'Marker','o', 'color','k');
psoc2=stairs(0:Hor_Sim,[State_ofC2 State_ofC2(:,end)],...
       'linewidth', 1.5,'Marker','o', 'color','k');
psoc3=stairs(0:Hor_Sim,[State_ofC3 State_ofC3(:,end)],...
       'linewidth', 1.5,'Marker','o', 'color','k');
pch1=stairs(0:Hor_Sim,[charge1 charge1(:,end)],...
       'linewidth', 1.5,'Marker','x', 'color','r');
pch2=stairs(0:Hor_Sim,[charge2 charge2(:,end)],...
       'linewidth', 1.5,'Marker','x', 'color','r');
pch3=stairs(0:Hor_Sim,[charge3 charge3(:,end)],...
       'linewidth', 1.5,'Marker','x', 'color','r');
% plot(xaxes,gen1,'LineWidth',1.5);
pdch1=stairs(0:Hor_Sim,[discharge1 discharge1(:,end)],...
       'linewidth', 1.5,'Marker','d', 'color','b');
pdch2=stairs(0:Hor_Sim,[discharge2 discharge2(:,end)],...
       'linewidth', 1.5,'Marker','d', 'color','b');
pdch3=stairs(0:Hor_Sim,[discharge3 discharge3(:,end)],...
       'linewidth', 1.5,'Marker','d', 'color','b');

   hl=legend([pd pg psoc1 pch1 pdch1],{'$sum(\bf{P^{d}})$','$sum(\bf{P^{g}})$','$\mathbf{E}$',...
       '$\bf{\sl{P}}^{\rm{ch}}$',...
       '$\bf{\sl{P}}^{\rm{dch}}$'});
   ax = gca;
ax.YGrid = 'on';
ax.GridLineStyle = '--';
ax.GridColor = 'k';
 set(hl, 'interpreter', 'latex')
hl.FontSize = 14;
% xticks([1 2])
% xlabel('Time (sec)')
ylabel('Power (MW)')
% legend('Pload_1','Pload_2','Pload_3','Pload_t_o_t','P_g','Location','best')
% print('M:\P H D PROJECT\CONFERENCE     P A P E R S\EEM 2018\matlabfigures\fig2','-djpeg','-r150')
% figure
% hold on

% p1=stairs(0:Hor_Sim,[charge charge(:,end)],...
%        'linewidth', 1,'Marker','o');
% % plot(xaxes,discharge,'LineWidth',1.5,'color','g');
% 
% p2=stairs(0:Hor_Sim,[discharge discharge(:,end)],...
%        'linewidth', 1,'Marker','s');
% 
% p3=stairs(0:Hor_Sim,[State_ofC State_ofC(:,end)],...
%        'linewidth', 1,'Marker','x');

xticks(1:Hor_Sim)
xlabel('Time (sec)','fontweight','bold')
ylabel('Power (MW)','fontweight','bold')
% plot(xaxes,State_ofC,'LineWidth',1.5);


axx = gca;
axx.YGrid = 'on';
axx.GridLineStyle = '--';
axx.GridColor = 'k';
axx.GridAlpha = 1;



% print('M:\P H D PROJECT\CONFERENCE     P A P E R S\EEM 2018\matlabfigures\fig3','-djpeg','-r150')