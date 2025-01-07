import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

sns.set_theme(palette='deep')

tips = sns.load_dataset('tips',data_home='seaborn-data',cache=True)
# sns.set_theme()
g = sns.jointplot(x="total_bill", y="tip", data=tips, kind="reg", color="darkblue")

plt.show()
