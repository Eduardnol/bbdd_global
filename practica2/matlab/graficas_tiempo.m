%FICHERO PEQUEÑO
Y = [(6+7+7)/3, (5+5+6)/3;  %Simple Query
    (59+77+60)/3, (33+26+22)/3;  %Complex Query
    (14+9+11)/3, (10+9+11)/3;   %Insert
    (11+7+10)/3,(14+7+7)/3;    %Update
    (7+16+9)/3, (8+8+6)/3];  %Delete
names = {'Simple Query'; 'Complex Query'; 'Insert';'Update'; 'Delete'};
 u = figure;
 subplot(2, 1, 1);
 bar(Y, 'LineWidth', 0.5)

 yticks(0:5:75);
 grid on
 grid minor
 
 title ('OLTP vs OLAP');
 ylabel('Tiempo en ms');
 xlabel('Tipo de dato usado');
 parametros = {'OLTP', 'OLAP'};
 legend(parametros)
 

set(gca,'xtick',(1:4),'xticklabel',names)

 t = uitable('Data',Y, 'ColumnName', parametros, 'RowName', names, 'ColumnWidth' , {50});
 
 % Auto-resize:
jScroll = findjobj(t);
jTable  = jScroll.getViewport.getView;
jTable.setAutoResizeMode(jTable.AUTO_RESIZE_SUBSEQUENT_COLUMNS);
drawnow;
 
subplot(2,1,2),plot(2)
pos = get(subplot(2,1,2),'position');
delete(subplot(2,1,2))
set(t,'units','normalized')
set(t,'position',pos)
set(u, 'Position',  [100, 100, 700, 600])


 