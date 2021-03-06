function plot_alt_stats(sat_data,sat)
% plot mean statistics
figure(1)
orient('tall')
subplot(2,4,1:2)
m_proj('mercator','long',sat_data.coord(1:2),'lat',sat_data.coord(3:4));
[CMCF,hh2]=m_contourf(sat.X,sat.Y,sat.alt_mean);
hold on
caxis([0 max(max(sat.alt_mean))]);
set(hh2,'EdgeColor','none');
m_gshhs_i('patch',[0 0.5 0],'EdgeColor','k');
xlabel('Longitude','FontWeight','bold')
ylabel('Latitude','FontWeight','bold')
m_grid('box','fancy','tickdir','in','FontWeight','Bold');
hcc=get(gca,'children');
tags=get(hcc,'Tag');
k=strmatch('m_grid',tags);
hgrd=hcc(k);
hp=findobj(gca,'Tag','m_grid_color');
set(hp,'Visible','off');
set(hgrd,'HandleVisibility','off');
k2=strmatch('m_gshhs_i',tags);
h_water=findobj(hcc(k2),'FaceColor',[1,1,1]);
set(h_water,'FaceColor','none');
colorbar('horizontal')
title('Mean H_{mo} (m)','fontweight','bold')

subplot(2,4,3:4)
m_proj('mercator','long',sat_data.coord(1:2),'lat',sat_data.coord(3:4));
[CMCF,hh2]=m_contourf(sat.X,sat.Y,sat.mod_bias);
hold on
caxis([-1.0 1.0])
set(hh2,'EdgeColor','none');
m_gshhs_i('patch',[0 0.5 0],'EdgeColor','k');
xlabel('Longitude','FontWeight','bold')
ylabel('Latitude','FontWeight','bold')
m_grid('box','fancy','tickdir','in','FontWeight','Bold');
hcc=get(gca,'children');
tags=get(hcc,'Tag');
k=strmatch('m_grid',tags);
hgrd=hcc(k);
hp=findobj(gca,'Tag','m_grid_color');
set(hp,'Visible','off');
set(hgrd,'HandleVisibility','off');
k2=strmatch('m_gshhs_i',tags);
h_water=findobj(hcc(k2),'FaceColor',[1,1,1]);
set(h_water,'FaceColor','none');
colorbar('horizontal')
title('H_{mo} Bias','fontweight','bold');

subplot(2,4,5:6)
m_proj('mercator','long',sat_data.coord(1:2),'lat',sat_data.coord(3:4));
[CMCF,hh2]=m_contourf(sat.X,sat.Y,sat.mod_rmse);
hold on
caxis([0 max(max(sat.mod_rmse))])%max(max(mod_rmse2))])
%caxis([0 2])
set(hh2,'EdgeColor','none');
m_gshhs_i('patch',[0 0.5 0],'EdgeColor','k');
xlabel('Longitude','FontWeight','bold')
ylabel('Latitude','FontWeight','bold')
m_grid('box','fancy','tickdir','in','FontWeight','Bold');
hcc=get(gca,'children');
tags=get(hcc,'Tag');
k=strmatch('m_grid',tags);
hgrd=hcc(k);
hp=findobj(gca,'Tag','m_grid_color');
set(hp,'Visible','off');
set(hgrd,'HandleVisibility','off');
k2=strmatch('m_gshhs_i',tags);
h_water=findobj(hcc(k2),'FaceColor',[1,1,1]);
set(h_water,'FaceColor','none');
colorbar('horizontal')
title('H_{mo} RMSE','fontweight','bold');

subplot(2,4,7:8)
m_proj('mercator','long',sat_data.coord(1:2),'lat',sat_data.coord(3:4));
[CMCF,hh2]=m_contourf(sat.X,sat.Y,sat.mod_si);
hold on
caxis([0 50])
set(hh2,'EdgeColor','none');
m_gshhs_i('patch',[0 0.5 0],'EdgeColor','k');
xlabel('Longitude','FontWeight','bold')
ylabel('Latitude','FontWeight','bold')
m_grid('box','fancy','tickdir','in','FontWeight','Bold');
hcc=get(gca,'children');
tags=get(hcc,'Tag');
k=strmatch('m_grid',tags);
hgrd=hcc(k);
hp=findobj(gca,'Tag','m_grid_color');
set(hp,'Visible','off');
set(hgrd,'HandleVisibility','off');
k2=strmatch('m_gshhs_i',tags);
h_water=findobj(hcc(k2),'FaceColor',[1,1,1]);
set(h_water,'FaceColor','none');
colorbar('horizontal')
title('H_{mo} Scatter Index','fontweight','bold');

set(gcf,'units','inches')
pos=get(gcf,'Position');
%pos(3:4)=[649,664];
   set(gcf,'PaperPositionMode','manual');
   set(gcf,'papersize',[11 8.5]);
   set(gcf,'Position',[0.5 0.5 10 7.5]);
fileout = ['WW3-',sat_data.sat,'-stats-',sat.yearmon];
print(gcf,'-dpng','-r500',fileout);
clf
