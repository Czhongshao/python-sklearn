# -*- coding: utf-8 -*-
"""
Created on Wed Jan  8 15:33:16 2025

@author: Cshao
"""

import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm

# 设置字体为支持中文的字体 (matplotlib默认是不支持中文的)
mpl.rcParams['font.family'] = 'SimHei'  # 使用黑体
mpl.rcParams['axes.unicode_minus'] = False  # 正确显示负号

# 固定随机种子以便结果可复现
np.random.seed(19680801)

# 创建图形和3D轴
fig = plt.figure()
ax = fig.add_subplot(projection='3d')

# 生成随机数据并计算二维直方图
x, y = np.random.rand(2, 100) * 4
hist, xedges, yedges = np.histogram2d(x, y, bins=4, range=[[0, 4], [0, 4]])

# 构造柱状体的锚点位置
xpos, ypos = np.meshgrid(xedges[:-1] + 0.25, yedges[:-1] + 0.25, indexing="ij")
xpos = xpos.ravel()
ypos = ypos.ravel()
zpos = 0

# 设置柱状体的宽度和高度
dx = dy = 0.5 * np.ones_like(zpos)
dz = hist.ravel()

# 使用色彩映射为柱状体赋予从红到蓝的颜色
norm = plt.Normalize(dz.min(), dz.max())  # 将高度值归一化到0-1之间
colors = cm.coolwarm(norm(dz))  # 使用 'coolwarm' 渐变色彩映射，从红到蓝

# 绘制带有黑色边框的柱状体
ax.bar3d(
    xpos, ypos, zpos, dx, dy, dz,
    color=colors,  # 内部填充颜色
    edgecolor='black',  # 设置边框为黑色
    zsort='average'  # 按柱状体高度进行绘制排序
)

# 添加颜色条，显示高度和颜色之间的对应关系
mappable = cm.ScalarMappable(cmap=cm.coolwarm, norm=norm)
mappable.set_array(dz)
fig.colorbar(mappable, ax=ax, shrink=0.5, aspect=10)

# 显示图形
plt.show()

