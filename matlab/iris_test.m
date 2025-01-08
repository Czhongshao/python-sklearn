%% 导入数据
clc; clear; close all;

% 读取 Iris 数据集
data_iris = readtable('seaborn-data\iris.csv');

%% 提取特征和类别
% 假设前四列是特征
X = data_iris{:, 1:4}; 
% 假设第五列是类别
Y = data_iris{:, 5}; 

% 获取特征名称
featureNames = data_iris.Properties.VariableNames(1:4);

% 获取类别名称和分配颜色
species = unique(Y);
colors = lines(length(species)); % 使用 MATLAB 的颜色映射

%% 创建成对散点图
figure;
numFeatures = size(X, 2); % 特征数量

% 遍历特征组合并绘制图形
for i = 1:numFeatures
    for j = 1:numFeatures
        subplot(numFeatures, numFeatures, (i - 1) * numFeatures + j);
        hold on;
        for k = 1:length(species)
            idx = strcmp(Y, species{k}); % 获取当前类别的索引
            if i == j
                % 对角线上的直方图
                histogram(X(idx, i), 10, 'FaceColor', colors(k, :), 'EdgeColor', 'none', 'Normalization', 'probability');
            else
                % 非对角线上的散点图
                scatter(X(idx, j), X(idx, i), 'MarkerEdgeColor', colors(k, :), 'MarkerFaceColor', colors(k, :));
            end
        end
        hold off;

        % 设置标题和坐标轴标签
        if i == j
            title(featureNames{i}, 'Interpreter', 'none', 'FontSize', 10);
        elseif i == numFeatures
            xlabel(featureNames{j}, 'Interpreter', 'none', 'FontSize', 8);
        end
        if j == 1
            ylabel(featureNames{i}, 'Interpreter', 'none', 'FontSize', 8);
        end
    end
end

% 设置图例和总体标题
sgtitle('Iris Data Pairwise Scatter Plot');
legend(species, 'Location', 'eastoutside', 'Interpreter', 'none'); % 图例放在图的右侧
