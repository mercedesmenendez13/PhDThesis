%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Biplots

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modified marker size to be more differentiated


sz=Diversity(1:80,1)
lallaverageXUbiTmp2000=lallaverageUbiTmpX2000*5;
greenavgUbiXTmp2000=greendigiaverageUbiTmpX2000*5;
digitalavgUbiXTmp2000=digitalaverageUbiTmpX2000*5;
greendigiavgUbiXTmp2000=greendigiaverageUbiTmpX2000*5;
criticalavgUbiXTmp2000=criticalaverageUbiTmpX2000*5;

scA = 1;

sz = sz/10 ; % Scale up the sizes for more differentiation
markerFaceAlpha=0.3
figure(1);
hold on;

% Scatter plot with differentiated markers
bubblechart(F(1:80,1), F(1:80,2),sz,"MarkerFaceAlpha",markerFaceAlpha); 
%scatter(V(green_indices,1), V(green_indices,2),"MarkerFaceAlpha",markerFaceAlpha); 
% Increased size for centroid markers
bubblechart(LallCentroidsX2000(1:11,1), LallCentroidsX2000(1:11,2),lallaverageXUbiTmp2000 , 'red');
bubblechart(CentroidsgreenX2000(:,1), CentroidsgreenX2000(:,2),greenavgUbiXTmp2000 , "green"); 
bubblechart(CentroidsdigitalX2000_DPTs(:,1), CentroidsdigitalX2000_DPTs(:,2),digitalavgUbiXTmp2000 , "yellow"); 
bubblechart(CentroidsgreendigiX2000(:,1), CentroidsgreendigiX2000(:,2), greendigiavgUbiXTmp2000, "cyan");
bubblechart(CentroidscriticalX2000(:,1), CentroidscriticalX2000(:,2),criticalavgUbiXTmp2000 , "magenta");


% Adjusted aspect ratio, grid, and box
daspect([1 1 1]);
grid on;
set(gca, 'GridLineStyle', '--', 'GridAlpha', 0.7);
box on;
ylim([ -1 2.5])
xlim([ -1 2])

% Labels and title
xlabel('CCA-dimension 1', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('CCA-dimension 2', 'FontSize', 12, 'FontWeight', 'bold');
title('CCA Dimension Analysis-EXPORTS', 'FontSize', 14, 'FontWeight', 'bold');

% Arrow plotting with enhanced visibility and legends
arrow_colors = {'b', '#FF8800', 'r', 'y', 'k', 'm', 'g', '#8B4513', 'c', '#008080'}; % '#000080' is navy blue

arrow_names = {'Arrow 1', 'Arrow 2', 'Arrow 3', 'Arrow 4', 'Arrow 5', 'Arrow 6', 'Arrow 7', 'Arrow 8', 'Arrow 9', 'Arrow 10'};

for i = 1:10
    arrow = [0, Arrows_x_star(i,1); 0, Arrows_x_star(i,2)];
    plot(arrow(1,:) * scA, arrow(2,:) * scA, 'Color', arrow_colors{i}, 'LineWidth', 2, 'DisplayName', arrow_names{i});
    
end


% Add text labels to the same subset of data points
for i = 1:80
    % Ensure that the index does not exceed the size of the countries_selection array
    if i <= numel(countries_selection)
        text(F(i, 1), F(i, 2), countries_selection{i}, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', ...
            'FontSize', 8); % Adjust font size as needed
    end
end
for i = 1:min(size(LallCentroidsX2000, 1), numel(lall_class))
    % Add text label for each data point with reduced font size
    text(LallCentroidsX2000(i,1), LallCentroidsX2000(i,2), lall_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsgreenX2000, 1), numel(green_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreenX2000(i,1), CentroidsgreenX2000(i,2), green_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsdigitalX2000_DPTs, 1), numel(digital_class))
    % Add text label for each data point with reduced font size
    text(CentroidsdigitalX2000_DPTs(i,1), CentroidsdigitalX2000_DPTs(i,2), digital_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidsgreendigiX2000, 1), numel(digitalgreen_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreendigiX2000(i,1), CentroidsgreendigiX2000(i,2), digitalgreen_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidscriticalX2000, 1), numel(criticalminerals_class))
    % Add text label for each data point with reduced font size
    text(CentroidscriticalX2000(i,1), CentroidscriticalX2000(i,2), criticalminerals_class{i}, ...
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


szz=Diversity(81:160,1)
lallaverageXUbiTmp2018=lallaverageUbiTmpX2018*5;
greenavgUbiXTmp2018=greendigiaverageUbiTmpX2018*5;
digitalavgUbiXTmp2018=digitalaverageUbiTmpX2018*5;
greendigiavgUbiXTmp2018=greendigiaverageUbiTmpX2018*5;
criticalavgUbiXTmp2018=criticalaverageUbiTmpX2018*5;

scA = 1;

szzs = szz/10; % Scale up the sizes for more differentiation
markerFaceAlpha=0.3
figure(2);
hold on;

% Scatter plot with differentiated markers
bubblechart(F(81:160,1), F(81:160,2),szzs,"MarkerFaceAlpha",markerFaceAlpha); 
%scatter(V(green_indices,1), V(green_indices,2),"MarkerFaceAlpha",markerFaceAlpha); 
% Increased size for centroid markers
bubblechart(LallCentroidsX2018(1:11,1), LallCentroidsX2018(1:11,2),lallaverageXUbiTmp2018 , 'red');
bubblechart(CentroidsgreenX2018(:,1), CentroidsgreenX2018(:,2),greenavgUbiXTmp2000 , "green"); 
bubblechart(CentroidsdigitalX2018_DPTs(:,1), CentroidsdigitalX2018_DPTs(:,2),digitalavgUbiXTmp2018 , "yellow"); 
bubblechart(CentroidsgreendigiX2018(:,1), CentroidsgreendigiX2018(:,2), greendigiavgUbiXTmp2018, "cyan");
bubblechart(CentroidscriticalX2018(:,1), CentroidscriticalX2018(:,2),criticalavgUbiXTmp2018 , "magenta");

% Adjusted aspect ratio, grid, and box
daspect([1 1 1]);
grid on;
set(gca, 'GridLineStyle', '--', 'GridAlpha', 0.7);
box on;
ylim([ -1 2.5])
xlim([ -1 2])
% Labels and title
xlabel('CCA-dimension 1', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('CCA-dimension 2', 'FontSize', 12, 'FontWeight', 'bold');
title('CCA Dimension Analysis-EXPORTS', 'FontSize', 14, 'FontWeight', 'bold');


% Arrow plotting with enhanced visibility and legends
arrow_colors = {'b', '#FF8800', 'r', 'y', 'k', 'm', 'g', '#8B4513', 'c', '#008080'}; % '#000080' is navy blue
arrow_names = {'Arrow 1', 'Arrow 2', 'Arrow 3', 'Arrow 4', 'Arrow 5', 'Arrow 6', 'Arrow 7', 'Arrow 8', 'Arrow 9', 'Arrow 10'};

for i = 1:10
    arrow = [0, Arrows_x_star(i,1); 0, Arrows_x_star(i,2)];
    plot(arrow(1,:) * scA, arrow(2,:) * scA, 'Color', arrow_colors{i}, 'LineWidth', 2, 'DisplayName', arrow_names{i});
    
end

% Add text labels to the same subset of data points
for i = 81:160
    % Ensure that the index does not exceed the size of the countries_selection array
    if i <= numel(countries_selection)
        text(F(i, 1), F(i, 2), countries_selection{i}, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', ...
            'FontSize', 8); % Adjust font size as needed
    end
end

for i = 1:min(size(LallCentroidsX2018, 1), numel(lall_class))
    % Add text label for each data point with reduced font size
    text(LallCentroidsX2018(i,1), LallCentroidsX2018(i,2), lall_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsgreenX2018, 1), numel(green_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreenX2018(i,1), CentroidsgreenX2018(i,2), green_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsdigitalX2018_DPTs, 1), numel(digital_class))
    % Add text label for each data point with reduced font size
    text(CentroidsdigitalX2018_DPTs(i,1), CentroidsdigitalX2018_DPTs(i,2), digital_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidsgreendigiX2018, 1), numel(digitalgreen_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreendigiX2018(i,1), CentroidsgreendigiX2018(i,2), digitalgreen_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidsgreendigiX2018, 1), numel(criticalminerals_class))
    % Add text label for each data point with reduced font size
    text(CentroidscriticalX2018(i,1), CentroidscriticalX2018(i,2), criticalminerals_class{i}, ...
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
% Modified marker size to be more differentiated

figure(7);
hold on;

% Scatter plot with differentiated markers
bubblechart(F(1:80,2), F(1:80,3),sz,"MarkerFaceAlpha",markerFaceAlpha); 
%scatter(V(green_indices,1), V(green_indices,2),"MarkerFaceAlpha",markerFaceAlpha); 
% Increased size for centroid markers
bubblechart(LallCentroidsX2000(1:11,2), LallCentroidsX2000(1:11,3),lallaverageXUbiTmp2000 , 'red');
bubblechart(CentroidsgreenX2000(:,2), CentroidsgreenX2000(:,3),greenavgUbiXTmp2000 , "green"); 
bubblechart(CentroidsdigitalX2000_DPTs(:,2), CentroidsdigitalX2000_DPTs(:,3),digitalavgUbiXTmp2000 , "yellow"); 
bubblechart(CentroidsgreendigiX2000(:,2), CentroidsgreendigiX2000(:,3), greendigiavgUbiXTmp2000, "cyan");
bubblechart(CentroidscriticalX2000(:,2), CentroidscriticalX2000(:,3),criticalavgUbiXTmp2000 , "magenta");


% Adjusted aspect ratio, grid, and box
daspect([1 1 1]);
grid on;
set(gca, 'GridLineStyle', '--', 'GridAlpha', 0.7);
box on;
ylim([ -2 1.5])
xlim([ -1 2.5])

% Labels and title
xlabel('CCA-dimension 2', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('CCA-dimension 3', 'FontSize', 12, 'FontWeight', 'bold');
title('CCA Dimension Analysis-EXPORTS 2000', 'FontSize', 14, 'FontWeight', 'bold');

% Arrow plotting with enhanced visibility and legends
arrow_colors = {'b', '#FF8800', 'r', 'y', 'k', 'm', 'g', '#8B4513', 'c', '#008080'}; % '#000080' is navy blue

arrow_names = {'Arrow 1', 'Arrow 2', 'Arrow 3', 'Arrow 4', 'Arrow 5', 'Arrow 6', 'Arrow 7', 'Arrow 8', 'Arrow 9', 'Arrow 10'};

for i = 1:10
    arrow = [0, Arrows_x_star(i,2); 0, Arrows_x_star(i,3)];
    plot(arrow(1,:) * scA, arrow(2,:) * scA, 'Color', arrow_colors{i}, 'LineWidth', 2, 'DisplayName', arrow_names{i});
    
end

% Add text labels to the same subset of data points
for i = 1:80
    % Ensure that the index does not exceed the size of the countries_selection array
    if i <= numel(countries_selection)
        text(F(i, 2), F(i, 3), countries_selection{i}, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', ...
            'FontSize', 8); % Adjust font size as needed
    end
end
for i = 1:min(size(LallCentroidsX2000, 1), numel(lall_class))
    % Add text label for each data point with reduced font size
    text(LallCentroidsX2000(i,2), LallCentroidsX2000(i,3), lall_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsgreenX2000, 1), numel(green_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreenX2000(i,2), CentroidsgreenX2000(i,3), green_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsdigitalX2000_DPTs, 1), numel(digital_class))
    % Add text label for each data point with reduced font size
    text(CentroidsdigitalX2000_DPTs(i,2), CentroidsdigitalX2000_DPTs(i,3), digital_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidsgreendigiX2000, 1), numel(digitalgreen_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreendigiX2000(i,2), CentroidsgreendigiX2000(i,3), digitalgreen_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidscriticalX2000, 1), numel(criticalminerals_class))
    % Add text label for each data point with reduced font size
    text(CentroidscriticalX2000(i,2), CentroidscriticalX2000(i,3), criticalminerals_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end


legend('All Countries','Lall Product Categories', 'Green', 'Digital', 'Green-Digital','Critical Minerals', 'GDP per capita','GrowthGDP', 'CO2 emissions per capita','Gini', 'Consumption emissions per capita',  "Material Footprint per capita",'Domestic Material Consumption per capita', 'ICT infraestructure','Non-Renewable energy %', 'Voice&Accountability','Location', 'northeastoutside');


figure(68);
hold on;

% Scatter plot with differentiated markers
bubblechart(F(81:160,2), F(81:160,3),szzs,"MarkerFaceAlpha",markerFaceAlpha); 
%scatter(V(green_indices,1), V(green_indices,2),"MarkerFaceAlpha",markerFaceAlpha); 
% Increased size for centroid markers
bubblechart(LallCentroidsX2018(1:11,2), LallCentroidsX2018(1:11,3),lallaverageXUbiTmp2018 , 'red');
bubblechart(CentroidsgreenX2018(:,2), CentroidsgreenX2018(:,3),greenavgUbiXTmp2000 , "green"); 
bubblechart(CentroidsdigitalX2018_DPTs(:,2), CentroidsdigitalX2018_DPTs(:,3),digitalavgUbiXTmp2018 , "yellow"); 
bubblechart(CentroidsgreendigiX2018(:,2), CentroidsgreendigiX2018(:,3), greendigiavgUbiXTmp2018, "cyan");
bubblechart(CentroidscriticalX2018(:,2), CentroidscriticalX2018(:,3),criticalavgUbiXTmp2018 , "magenta");

% Adjusted aspect ratio, grid, and box
daspect([1 1 1]);
grid on;
set(gca, 'GridLineStyle', '--', 'GridAlpha', 0.7);
box on;
ylim([ -2 1.5])
xlim([ -1 2.5])
% Labels and title
xlabel('CCA-dimension 2', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('CCA-dimension 3', 'FontSize', 12, 'FontWeight', 'bold');
title('CCA Dimension Analysis-EXPORTS 2018', 'FontSize', 14, 'FontWeight', 'bold');


% Arrow plotting with enhanced visibility and legends
arrow_colors = {'b', '#FF8800', 'r', 'y', 'k', 'm', 'g', '#8B4513', 'c', '#008080'}; % '#000080' is navy blue
arrow_names = {'Arrow 1', 'Arrow 2', 'Arrow 3', 'Arrow 4', 'Arrow 5', 'Arrow 6', 'Arrow 7', 'Arrow 8', 'Arrow 9', 'Arrow 10'};

for i = 1:10
    arrow = [0, Arrows_x_star(i,2); 0, Arrows_x_star(i,3)];
    plot(arrow(1,:) * scA, arrow(2,:) * scA, 'Color', arrow_colors{i}, 'LineWidth', 2, 'DisplayName', arrow_names{i});
    
end

% Add text labels to the same subset of data points
for i = 81:160
    % Ensure that the index does not exceed the size of the countries_selection array
    if i <= numel(countries_selection)
        text(F(i, 2), F(i, 3), countries_selection{i}, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', ...
            'FontSize', 8); % Adjust font size as needed
    end
end

for i = 1:min(size(LallCentroidsX2018, 1), numel(lall_class))
    % Add text label for each data point with reduced font size
    text(LallCentroidsX2018(i,2), LallCentroidsX2018(i,3), lall_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsgreenX2018, 1), numel(green_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreenX2018(i,2), CentroidsgreenX2018(i,3), green_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 6 (adjust as needed)
end

for i = 1:min(size(CentroidsdigitalX2018_DPTs, 1), numel(digital_class))
    % Add text label for each data point with reduced font size
    text(CentroidsdigitalX2018_DPTs(i,2), CentroidsdigitalX2018_DPTs(i,3), digital_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidsgreendigiX2018, 1), numel(digitalgreen_class))
    % Add text label for each data point with reduced font size
    text(CentroidsgreendigiX2018(i,2), CentroidsgreendigiX2018(i,3), digitalgreen_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

for i = 1:min(size(CentroidsgreendigiX2018, 1), numel(criticalminerals_class))
    % Add text label for each data point with reduced font size
    text(CentroidscriticalX2018(i,2), CentroidscriticalX2018(i,3), criticalminerals_class{i}, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 8); % Set the font size to 8 (adjust as needed)
end

legend('All Countries','Lall Product Categories', 'Green', 'Digital', 'Green-Digital','Critical Minerals', 'GDP per capita','GrowthGDP', 'CO2 emissions per capita','Gini', 'Consumption emissions per capita',  "Material Footprint per capita",'Domestic Material Consumption per capita', 'ICT infraestructure','Non-Renewable energy %', 'Voice&Accountability','Location', 'northeastoutside');

% Enhance the appearance of the plot window
set(gca, 'FontSize', 12);


saveas(gcf, 'countries_products_space_2018M12.jpg');
