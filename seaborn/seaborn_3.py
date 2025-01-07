import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

# sns.set_theme(palette='deep')
palette = sns.color_palette(["darkblue"])
sns.set_style(palette)
iris = sns.load_dataset('iris',data_home='seaborn-data',cache=True)
# sns.set_palette("darkblue")

a = sns.pairplot(iris) # 绘制双变量分布
plt.show()