%% 数据准备
% 初始化数据矩阵
years = 2016:2021; % 年份从2016到2021
months = 1:12; % 12个月
baseTemp = 5; % 假设1月的基础温度为5°C
monthDelta = [2, 3, 5, 8, 12, 16, 18, 17, 14, 11, 8, 5]; % 每月温度变化的基准值
warmingEffect = 0.3 * (years - min(years)); % 全球变暖效应，每年增加0.3°C

% 生成模拟数据
TempData6Years = repmat(baseTemp, 1, 12) + repmat(monthDelta, length(years), 1) + warmingEffect.';

% 添加随机扰动以模拟实际观测中的自然波动
TempData6Years = TempData6Years + randn(size(TempData6Years)) * 2; % 随机扰动±2°C

% 确保温度值在合理范围内
TempData6Years(TempData6Years < -5) = -5; % 最低温度不低于-5°C
TempData6Years(TempData6Years > 40) = 40; % 最高温度不超过40°C

%% 颜色定义
map = slanCM('viridis'); % 使用'slanCM'函数定义颜色映射

%% 绘制高度赋色的三维柱状图
figureHandle = figure;
b = bar3(TempData6Years, 0.5);
for n = 1:numel(b)
    cdata = get(b(n), 'zdata');
    cdata = repmat(max(cdata, [], 2), 1, 4);
    set(b(n), 'cdata', cdata, 'facecolor', 'flat');
end
hTitle = title(sprintf("Average Monthly Temperatures from %d to %d", 2016, 2021));
hXLabel = xlabel("Month");
hYLabel = ylabel("Year");
hZLabel = zlabel("Temperature (℃)");

%% 细节优化
% 赋色
colormap(map);
% colorbar;

% 区间调整
temp = minmax(TempData6Years(:)');
clim(temp);

% 坐标区调整
set(gca, 'Box', 'off', ... % 边框
    'LineWidth', 1, 'GridLineStyle', '-', ... % 坐标轴线宽
    'XGrid', 'off', 'YGrid', 'off', 'ZGrid', 'on', ... % 网格
    'TickDir', 'out', 'TickLength', [.015 .015], ... % 刻度
    'XMinorTick', 'off', 'YMinorTick', 'off', 'ZMinorTick', 'off', ... % 小刻度
    'XColor', [.1 .1 .1], 'YColor', [.1 .1 .1], 'ZColor', [.1 .1 .1], ... % 坐标轴颜色
    'XTickLabel', {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'}, ... % 月份标签
    'YTickLabel', years); % 年份标签

% 字体和字号
set(gca, 'FontName', 'Helvetica');
set([hXLabel, hYLabel, hZLabel], 'FontName', 'AvantGarde');
set(gca, 'FontSize', 10);
set([hXLabel, hYLabel, hZLabel], 'FontSize', 12);
set(hTitle, 'FontSize', 12, 'FontWeight', 'bold');

% 背景颜色
set(gcf, 'Color', [1 1 1]);

%% 图片输出
print(figureHandle, 'test1.png', '-r300', '-dpng');