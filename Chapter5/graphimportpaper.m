%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Biplots

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modified marker size to be more differentiated


yy=Diversity(161:240,1)
lallaverageMUbiTmp2000=lallaverageUbiTmpM2000*5;
greenavgUbiMTmp2000=greendigiaverageUbiTmpM2000*5;
digitalavgUbiMTmp2000=digitalaverageUbiTmpM2000*5;
greendigiavgUbiMTmp2000=greendigiaverageUbiTmpM2000*5;
criticalavgUbiMTmp2000=criticalaverageUbiTmpM2000*5;

scA = 1;

yyy = yy/10; % Scale up the sizes for more differentiation
markerFaceAlpha=0.3
figure(999);
hold on;

% Scatter plot with differentiated markers
bubblechart(F(161:240,1), F(161:240,2),yyy,"MarkerFaceAlpha",markerFaceAlpha); 
%scatter(V(green_indices,1), V(green_indices,2),"MarkerFaceAlpha",markerFaceAlpha); 
% Increased size for centroid markers
bubblechart(LallCentroidsM2000(1:11,1), LallCentroidsM2000(1:11,2),lallaverageMUbiTmp2000 , 'red');
bubblechart(CentroidsgreenM2000(:,1), CentroidsgreenM2000(:,2),greenavgUbiMTmp2000 , "green"); 
bubblechart(CentroidsdigitalM2000_DPTs(:,1), CentroidsdigitalM2000_DPTs(:,2),digitalavgUbiMTmp2000 , "yellow"); 
bubblechart(CentroidsgreendigiM2000(:,1), CentroidsgreendigiM2000(:,2), greendigiavgUbiMTmp2000, "cyan");
bubblechart(CentroidscriticalM2000(:,1), CentroidscriticalM2000(:,2),criticalavgUbiMTmp2000 , "magenta");


% Adjusted aspect ratio, grid, and box
daspect([1 1 1]);
grid on;
set(gca, 'GridLineStyle', '--', 'GridAlpha', 0.7);
box on;
ylim([ -1 2])
xlim([ -1 1])

% Labels and title
xlabel('CCA-dimension 1', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('CCA-dimension 2', 'FontSize', 12, 'FontWeight', 'bold');
title('CCA Dimension Analysis-IMPORTS 2000', 'FontSize', 14, 'FontWeight', 'bold');

% Arrow plotting with enhanced visibility and legends
arrow_colors = {'b', '#FF8800', 'r', 'y', 'k', 'm', 'g', '#8B4513', 'c', '#008080'}; % '#000080' is navy blue

arrow_names = {'Arrow 1', 'Arrow 2', 'Arrow 3', 'Arrow 4', 'Arrow 5', 'Arrow 6', 'Arrow 7', 'Arrow 8', 'Arrow 9', 'Arrow 10'};

for i = 1:10
    arrow = [0, Arrows_x_star(i,1); 0, Arrows_x_star(i,2)];
    plot(arrow(1,:) * scA, arrow(2,:) * scA, 'Color', arrow_colors{i}, 'LineWidth', 2, 'DisplayName', arrow_names{i});
    
end

% Add text labels to the same subset of data points
for i = 161:240
    % Ensure that the index does not exceed the size of the countries_selection array
    if i <= numel(countries_selection)
        text(F(i, 1), F(i, 2), countries_selection{i}, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', ...
            'FontSize', 8); % Adjust font size as needed
    end
end
for i = 1:min(size(LallCentroidsM2000, 1), numel(lall_class))
    % Add text label for each data point with reduced font size
    text(LallCentroidsM2000(i,1), LallCentroidsM2000(i,2), lall_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsgreenM2000, 1), numel(green_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreenM2000(i,1), CentroidsgreenM2000(i,2), green_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsdigitalM2000_DPTs, 1), numel(digital_class))
    % Add text label for each data point with reduced font size
    text(CentroidsdigitalM2000_DPTs(i,1), CentroidsdigitalM2000_DPTs(i,2), digital_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidsgreendigiM2000, 1), numel(digitalgreen_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreendigiM2000(i,1), CentroidsgreendigiM2000(i,2), digitalgreen_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidscriticalM2000, 1), numel(criticalminerals_class))
    % Add text label for each data point with reduced font size
    text(CentroidscriticalM2000(i,1), CentroidscriticalM2000(i,2), criticalminerals_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end


legend('All Countries','Lall Product Categories', 'Green', 'Digital', 'Green-Digital','Critical Minerals', 'GDP per capita','GrowthGDP', 'CO2 emissions per capita','Gini', 'Consumption emissions per capita',  "Material Footprint per capita",'Domestic Material Consumption per capita', 'ICT infraestructure','Non-Renewable energy %', 'Voice&Accountability','Location', 'northeastoutside');

% Add legend
%legend('Location', 'bestoutside', 'FontSize', 10);

% Enhance the appearance of the plot window
set(gca, 'FontSize', 12);

saveas(gcf, 'countries_products_space_2018X12.jpg');


rr=Diversity(241:320,1)
lallaverageMUbiTmp2018=lallaverageUbiTmpM2018*5;
greenavgUbiMTmp2018=greendigiaverageUbiTmpM2018*5;
digitalavgUbiMTmp2018=digitalaverageUbiTmpM2018*5;
greendigiavgUbiMTmp2018=greendigiaverageUbiTmpM2018*5;
criticalavgUbiMTmp2018=criticalaverageUbiTmpM2018*5;

scA = 1;

rrr = rr/10; % Scale up the sizes for more differentiation
markerFaceAlpha=0.3
figure(7256);
hold on;

% Scatter plot with differentiated markers
bubblechart(F(241:320,1), F(241:320,2),rrr,"MarkerFaceAlpha",markerFaceAlpha); 
%scatter(V(green_indices,1), V(green_indices,2),"MarkerFaceAlpha",markerFaceAlpha); 
% Increased size for centroid markers
bubblechart(LallCentroidsM2018(1:11,1), LallCentroidsM2018(1:11,2),lallaverageMUbiTmp2018 , 'red');
bubblechart(CentroidsgreenM2018(:,1), CentroidsgreenM2018(:,2),greenavgUbiMTmp2000 , "green"); 
bubblechart(CentroidsdigitalM2018_DPTs(:,1), CentroidsdigitalM2018_DPTs(:,2),digitalavgUbiMTmp2018 , "yellow"); 
bubblechart(CentroidsgreendigiM2018(:,1), CentroidsgreendigiM2018(:,2), greendigiavgUbiMTmp2018, "cyan");
bubblechart(CentroidscriticalM2018(:,1), CentroidscriticalM2018(:,2),criticalavgUbiMTmp2018 , "magenta");

% Adjusted aspect ratio, grid, and box
daspect([1 1 1]);
grid on;
set(gca, 'GridLineStyle', '--', 'GridAlpha', 0.7);
box on;
ylim([ -1 2])
xlim([ -1 1])
% Labels and title
xlabel('CCA-dimension 1', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('CCA-dimension 2', 'FontSize', 12, 'FontWeight', 'bold');
title('CCA Dimension Analysis-IMPORTS 2018', 'FontSize', 14, 'FontWeight', 'bold');


% Arrow plotting with enhanced visibility and legends
arrow_colors = {'b', '#FF8800', 'r', 'y', 'k', 'm', 'g', '#8B4513', 'c', '#008080'}; % '#000080' is navy blue
arrow_names = {'Arrow 1', 'Arrow 2', 'Arrow 3', 'Arrow 4', 'Arrow 5', 'Arrow 6', 'Arrow 7', 'Arrow 8', 'Arrow 9', 'Arrow 10'};

for i = 1:10
    arrow = [0, Arrows_x_star(i,1); 0, Arrows_x_star(i,2)];
    plot(arrow(1,:) * scA, arrow(2,:) * scA, 'Color', arrow_colors{i}, 'LineWidth', 2, 'DisplayName', arrow_names{i});
    
end

% Add text labels to the same subset of data points
for i = 241:320
    % Ensure that the index does not exceed the size of the countries_selection array
    if i <= numel(countries_selection)
        text(F(i, 1), F(i, 2), countries_selection{i}, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', ...
            'FontSize', 8); % Adjust font size as needed
    end
end

for i = 1:min(size(LallCentroidsM2018, 1), numel(lall_class))
    % Add text label for each data point with reduced font size
    text(LallCentroidsM2018(i,1), LallCentroidsM2018(i,2), lall_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsgreenM2018, 1), numel(green_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreenM2018(i,1), CentroidsgreenM2018(i,2), green_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsdigitalM2018_DPTs, 1), numel(digital_class))
    % Add text label for each data point with reduced font size
    text(CentroidsdigitalM2018_DPTs(i,1), CentroidsdigitalM2018_DPTs(i,2), digital_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidsgreendigiM2018, 1), numel(digitalgreen_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreendigiM2018(i,1), CentroidsgreendigiM2018(i,2), digitalgreen_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidsgreendigiM2018, 1), numel(criticalminerals_class))
    % Add text label for each data point with reduced font size
    text(CentroidscriticalM2018(i,1), CentroidscriticalM2018(i,2), criticalminerals_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

legend('All Countries','Lall Product Categories', 'Green', 'Digital', 'Green-Digital','Critical Minerals', 'GDP per capita','GrowthGDP', 'CO2 emissions per capita','Gini', 'Consumption emissions per capita',  "Material Footprint per capita",'Domestic Material Consumption per capita', 'ICT infraestructure','Non-Renewable energy %', 'Voice&Accountability','Location', 'northeastoutside');

% Enhance the appearance of the plot window
set(gca, 'FontSize', 12);


saveas(gcf, 'countries_products_space_2018M12.jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Biplots

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% other dimensions 

figure(76);
hold on;

% Scatter plot with differentiated markers
bubblechart(F(161:240,2), F(161:240,3),yyy,"MarkerFaceAlpha",markerFaceAlpha); 
%scatter(V(green_indices,1), V(green_indices,2),"MarkerFaceAlpha",markerFaceAlpha); 
% Increased size for centroid markers
bubblechart(LallCentroidsM2000(1:11,2), LallCentroidsM2000(1:11,3),lallaverageMUbiTmp2000 , 'red');
bubblechart(CentroidsgreenM2000(:,2), CentroidsgreenM2000(:,3),greenavgUbiMTmp2000 , "green"); 
bubblechart(CentroidsdigitalM2000_DPTs(:,2), CentroidsdigitalM2000_DPTs(:,3),digitalavgUbiMTmp2000 , "yellow"); 
bubblechart(CentroidsgreendigiM2000(:,2), CentroidsgreendigiM2000(:,3), greendigiavgUbiMTmp2000, "cyan");
bubblechart(CentroidscriticalM2000(:,2), CentroidscriticalM2000(:,3),criticalavgUbiMTmp2000 , "magenta");


% Adjusted aspect ratio, grid, and box
daspect([1 1 1]);
grid on;
set(gca, 'GridLineStyle', '--', 'GridAlpha', 0.7);
box on;
ylim([ -0.6 1.2])
xlim([ -1 1])

% Labels and title
xlabel('CCA-dimension 2', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('CCA-dimension 3', 'FontSize', 12, 'FontWeight', 'bold');
title('CCA Dimension Analysis-IMPORTS 2000', 'FontSize', 14, 'FontWeight', 'bold');

% Arrow plotting with enhanced visibility and legends
arrow_colors = {'b', '#FF8800', 'r', 'y', 'k', 'm', 'g', '#8B4513', 'c', '#008080'}; % '#000080' is navy blue

arrow_names = {'Arrow 1', 'Arrow 2', 'Arrow 3', 'Arrow 4', 'Arrow 5', 'Arrow 6', 'Arrow 7', 'Arrow 8', 'Arrow 9', 'Arrow 10'};

for i = 1:10
    arrow = [0, Arrows_x_star(i,2); 0, Arrows_x_star(i,3)];
    plot(arrow(1,:) * scA, arrow(2,:) * scA, 'Color', arrow_colors{i}, 'LineWidth', 2, 'DisplayName', arrow_names{i});
    
end

% Add text labels to the same subset of data points
for i = 161:240
    % Ensure that the index does not exceed the size of the countries_selection array
    if i <= numel(countries_selection)
        text(F(i, 2), F(i, 3), countries_selection{i}, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', ...
            'FontSize', 8); % Adjust font size as needed
    end
end
for i = 1:min(size(LallCentroidsM2000, 1), numel(lall_class))
    % Add text label for each data point with reduced font size
    text(LallCentroidsM2000(i,2), LallCentroidsM2000(i,3), lall_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsgreenM2000, 1), numel(green_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreenM2000(i,2), CentroidsgreenM2000(i,3), green_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsdigitalM2000_DPTs, 1), numel(digital_class))
    % Add text label for each data point with reduced font size
    text(CentroidsdigitalM2000_DPTs(i,2), CentroidsdigitalM2000_DPTs(i,3), digital_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidsgreendigiM2000, 1), numel(digitalgreen_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreendigiM2000(i,2), CentroidsgreendigiM2000(i,3), digitalgreen_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidscriticalM2000, 1), numel(criticalminerals_class))
    % Add text label for each data point with reduced font size
    text(CentroidscriticalM2000(i,2), CentroidscriticalM2000(i,3), criticalminerals_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end


legend('All Countries','Lall Product Categories', 'Green', 'Digital', 'Green-Digital','Critical Minerals', 'GDP per capita','GrowthGDP', 'CO2 emissions per capita','Gini', 'Consumption emissions per capita',  "Material Footprint per capita",'Domestic Material Consumption per capita', 'ICT infraestructure','Non-Renewable energy %', 'Voice&Accountability','Location', 'northeastoutside');

% Add legend
%legend('Location', 'bestoutside', 'FontSize', 10);

% Enhance the appearance of the plot window
set(gca, 'FontSize', 12);

saveas(gcf, 'countries_products_space_2018X12.jpg');

figure(5467);
hold on;

% Scatter plot with differentiated markers
bubblechart(F(241:320,2), F(241:320,3),rrr,"MarkerFaceAlpha",markerFaceAlpha); 
%scatter(V(green_indices,1), V(green_indices,2),"MarkerFaceAlpha",markerFaceAlpha); 
% Increased size for centroid markers
bubblechart(LallCentroidsM2018(1:11,2), LallCentroidsM2018(1:11,3),lallaverageMUbiTmp2018 , 'red');
bubblechart(CentroidsgreenM2018(:,2), CentroidsgreenM2018(:,3),greenavgUbiMTmp2000 , "green"); 
bubblechart(CentroidsdigitalM2018_DPTs(:,2), CentroidsdigitalM2018_DPTs(:,3),digitalavgUbiMTmp2018 , "yellow"); 
bubblechart(CentroidsgreendigiM2018(:,2), CentroidsgreendigiM2018(:,3), greendigiavgUbiMTmp2018, "cyan");
bubblechart(CentroidscriticalM2018(:,2), CentroidscriticalM2018(:,3),criticalavgUbiMTmp2018 , "magenta");

% Adjusted aspect ratio, grid, and box
daspect([1 1 1]);
grid on;
set(gca, 'GridLineStyle', '--', 'GridAlpha', 0.7);
box on;
%ylim([ -0.6 1.2])
%xlim([ -1 1.5])
% Labels and title
xlabel('CCA-dimension 2', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('CCA-dimension 3', 'FontSize', 12, 'FontWeight', 'bold');
title('CCA Dimension Analysis-IMPORTS 2018', 'FontSize', 14, 'FontWeight', 'bold');


% Arrow plotting with enhanced visibility and legends
arrow_colors = {'b', '#FF8800', 'r', 'y', 'k', 'm', 'g', '#8B4513', 'c', '#008080'}; % '#000080' is navy blue
arrow_names = {'Arrow 1', 'Arrow 2', 'Arrow 3', 'Arrow 4', 'Arrow 5', 'Arrow 6', 'Arrow 7', 'Arrow 8', 'Arrow 9', 'Arrow 10'};

for i = 1:10
    arrow = [0, Arrows_x_star(i,2); 0, Arrows_x_star(i,3)];
    plot(arrow(1,:) * scA, arrow(2,:) * scA, 'Color', arrow_colors{i}, 'LineWidth', 2, 'DisplayName', arrow_names{i});
    
end

% Add text labels to the same subset of data points
for i = 241:320
    % Ensure that the index does not exceed the size of the countries_selection array
    if i <= numel(countries_selection)
        text(F(i, 2), F(i, 3), countries_selection{i}, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', ...
            'FontSize', 8); % Adjust font size as needed
    end
end

for i = 1:min(size(LallCentroidsM2018, 1), numel(lall_class))
    % Add text label for each data point with reduced font size
    text(LallCentroidsM2018(i,2), LallCentroidsM2018(i,3), lall_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsgreenM2018, 1), numel(green_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreenM2018(i,2), CentroidsgreenM2018(i,3), green_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsdigitalM2018_DPTs, 1), numel(digital_class))
    % Add text label for each data point with reduced font size
    text(CentroidsdigitalM2018_DPTs(i,2), CentroidsdigitalM2018_DPTs(i,3), digital_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidsgreendigiM2018, 1), numel(digitalgreen_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreendigiM2018(i,2), CentroidsgreendigiM2018(i,3), digitalgreen_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidsgreendigiM2018, 1), numel(criticalminerals_class))
    % Add text label for each data point with reduced font size
    text(CentroidscriticalM2018(i,2), CentroidscriticalM2018(i,3), criticalminerals_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

legend('All Countries','Lall Product Categories', 'Green', 'Digital', 'Green-Digital','Critical Minerals', 'GDP per capita','GrowthGDP', 'CO2 emissions per capita','Gini', 'Consumption emissions per capita',  "Material Footprint per capita",'Domestic Material Consumption per capita', 'ICT infraestructure','Non-Renewable energy %', 'Voice&Accountability','Location', 'northeastoutside');

% Enhance the appearance of the plot window
set(gca, 'FontSize', 12);


saveas(gcf, 'countries_products_space_2018M12.jpg');