function plotLoss(data, options, numImagenesTrain, altura, dir)
% Calcular batchsize
batchSize = options.MiniBatchSize;
% Calcular cuantas iteraciones tiene una epoch
iteracionesPorEpoch = numImagenesTrain / batchSize;
% Calcular epochs
maxEpochs = length(data.TrainingLoss)/iteracionesPorEpoch; %options.MaxEpochs;


figure
clf

% Primer recuadro
x = [0 iteracionesPorEpoch iteracionesPorEpoch 0];
y =[0 0 altura altura];

% Rellenar el resto de recuadros
xx = [];
yy = [];

% Recuadro de la primera epoch
xx(end+1) = x(1);
xx(end+1) = x(2);
xx(end+1) = x(3);
xx(end+1) = x(4);
yy(end+1) = y(1);
yy(end+1) = y(2);
yy(end+1) = y(3);
yy(end+1) = y(4);
hold on

% Recuadros del resto de epochs
for i=2: maxEpochs
    
    x(2) = x(2) + iteracionesPorEpoch;
    x(3) = x(3) + iteracionesPorEpoch;
    xx(end+1) = x(1);
    xx(end+1) = x(2);
    xx(end+1) = x(3);
    xx(end+1) = x(4);
    
    yy(end+1) = y(1);
    yy(end+1) = y(2);
    yy(end+1) = y(3);
    yy(end+1) = y(4);
    
    % Se alternan colores 
    if mod(i,2) == 0
        patch(xx,yy,'white', 'EdgeColor','none')
    else
        patch(xx,yy, [0.80, 0.80, 0.80], 'EdgeColor','none')
    end
   
end

% Pintar las graficas  
plot(data.TrainingLoss)

% Pintar grid en el eje Y
ticks_y=[];
for i=1:1: altura-1
    plot([0 length(data.TrainingLoss)], [i i], 'color',[100 100 100]/255, 'LineStyle', ':');
    ticks_y = [ticks_y i];
end

% Establecer los límites de los ejes
ylim([0 altura]);
xlim([0 length(data.TrainingLoss)]);
xlabel('Epoch');
ylabel('Loss');
%axis square % Imagen cuadrada

% Establecer el titulo y modificar su posición para que no se solape
t=title('Función de pérdida');
t.Position(2) = t.Position(2);

hold on

% Pintar tambien la validación
% Quedarse con los valores correctos de la validación
x = 1:length(data.ValidationLoss);
x = x(~isnan(data.ValidationLoss));
y = data.ValidationLoss(~isnan(data.ValidationLoss));
plot(x,y,'r-', 'LineWidth',2);

% Leyenda
L(1) = plot(nan, nan, 'b-', 'LineWidth',2);
L(2) = plot(nan, nan, 'r-', 'LineWidth',2);
legend(L, {'TrainingLoss', 'ValidationLoss'});

yticks(ticks_y)
xticks([0])
set(gca,'FontSize',12)

% Quitar espacios en blanco del plot
%set(gcf,'position',[100,100,500,550])
%set(gcf,'position',[0,0,maxEpochs*25,720])
set(gcf,'position',[100,100,980,550])


ax = gca;
ax.XAxis.Exponent=0;
left = 0.1;
bottom = 0.13;
ax_width =  0.9;
ax_height = 0.78;
%ax.Position = [left bottom ax_width ax_height];

% Añadir el eje de las epochs
hAx(1)=gca;
hAx(2)=axes('Position',hAx(1).Position,'XAxisLocation','bottom','YAxisLocation','right','color','none', 'FontSize',12);
hAx(2).XLim = [0 maxEpochs];
%axis square % Imagen cuadrada


% Quitar el segundo eje Y
set(gca,'ytick',[]);
set(gca,'yticklabel',[]);

hold off

print([dir,'\Loss_pro'],'-dsvg'); % Guardar imagen

end