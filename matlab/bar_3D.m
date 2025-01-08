% 设置随机种子以便结果可复现
rng(19680801);

% 生成随机数据并计算二维直方图
x = rand(1, 300) * 4;
y = rand(1, 300) * 4;
edges = linspace(0, 4, 5); % 边界范围，分4个区间
[N, ~, ~] = histcounts2(x, y, edges, edges); % 计算二维直方图

% 构造柱状体的锚点位置
[xpos, ypos] = meshgrid(edges(1:end-1) + 0.25, edges(1:end-1) + 0.25);
xpos = xpos(:); % 展平为列向量
ypos = ypos(:); % 展平为列向量
zpos = zeros(size(xpos)); % z方向起点为0

% 设置柱状体的宽度和高度
dx = 0.5 * ones(size(xpos)); % x方向宽度
dy = 0.5 * ones(size(ypos)); % y方向宽度
dz = N(:); % 柱状体高度

% 归一化高度值到 [0, 1]
dz_norm = (dz - min(dz)) / (max(dz) - min(dz));

% 生成颜色映射
cmap = slanCM('coolwarm', 256); % 生成256种颜色的 'coolwarm' 颜色映射

% 使用颜色映射为柱状体设置颜色
colors = interp1(linspace(0, 1, size(cmap, 1)), cmap, dz_norm);

% 创建3D柱状图
figure;
hold on;
for i = 1:length(xpos)
    % 使用 patch 函数绘制具有指定颜色和边框的柱状体
    patch('Vertices', [xpos(i)-dx(i)/2, ypos(i)-dy(i)/2, zpos(i); ...
                       xpos(i)-dx(i)/2, ypos(i)+dy(i)/2, zpos(i); ...
                       xpos(i)+dx(i)/2, ypos(i)+dy(i)/2, zpos(i); ...
                       xpos(i)+dx(i)/2, ypos(i)-dy(i)/2, zpos(i); ...
                       xpos(i)-dx(i)/2, ypos(i)-dy(i)/2, zpos(i)+dz(i); ...
                       xpos(i)-dx(i)/2, ypos(i)+dy(i)/2, zpos(i)+dz(i); ...
                       xpos(i)+dx(i)/2, ypos(i)+dy(i)/2, zpos(i)+dz(i); ...
                       xpos(i)+dx(i)/2, ypos(i)-dy(i)/2, zpos(i)+dz(i)], ...
          'Faces', [1 2 6 5; 2 3 7 6; 3 4 8 7; 4 1 5 8; 1 2 3 4; 5 6 7 8], ...
          'FaceColor', colors(i, :), ...
          'EdgeColor', 'black'); % 设置边框颜色为黑色
end

% 添加颜色条，显示高度和颜色之间的对应关系
colormap(cmap);
colorbar;
clim([min(dz), max(dz)]); % 设置颜色条范围为柱状体高度的范围

% 设置轴标签
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
view(3); % 3D视图
hold off;