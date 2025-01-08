%% 导入数据
clc; clear; close all;

% 假设数据表 'tips' 已加载
tips = readtable('seaborn-data\tips.csv'); % 替换为实际数据路径

% 提取变量
x = tips.total_bill;
y = tips.tip;

%% 设置布局
tiledlayout(3, 3, 'Padding', 'compact', 'TileSpacing', 'compact');

% 上方分布图
nexttile(1, [1, 2]);
histogram(x, 'Normalization', 'pdf', 'FaceColor', [0, 0, 0.55], 'EdgeColor', 'none');
hold on;
[f, xi] = ksdensity(x); % 核密度估计
plot(xi, f, 'LineWidth', 1.5, 'Color', [0, 0, 0.55]);
title('Distribution of Total Bill');
set(gca, 'XTickLabel', []);

% 右侧分布图
nexttile(6, [2, 1]);
histogram(y, 'Normalization', 'pdf', 'FaceColor', [0, 0, 0.55], 'EdgeColor', 'none', 'Orientation', 'horizontal');
hold on;
[f, xi] = ksdensity(y); % 核密度估计
plot(f, xi, 'LineWidth', 1.5, 'Color', [0, 0, 0.55]); % 注意核密度输出顺序
set(gca, 'YTickLabel', []);
view([90 -90]); % 旋转以适应右侧布局

% 主散点图和回归线
nexttile(4, [2, 2]);
hold on;
scatter(x, y, 50, 'MarkerFaceColor', [0, 0, 0.55], 'MarkerEdgeColor', 'none', 'MarkerFaceAlpha', 0.7);

% 拟合回归模型
mdl = fitlm(x, y);
xFit = linspace(min(x), max(x), 100);
yFit = predict(mdl, xFit');
plot(xFit, yFit, 'Color', [0, 0, 0.55], 'LineWidth', 1.5);

% 添加标题和坐标轴标签
xlabel('Total Bill');
ylabel('Tip');
title('Scatter Plot with Regression Line');
grid on;
box on;
