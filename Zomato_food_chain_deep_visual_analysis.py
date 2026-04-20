import pandas as pd

df = pd.read_csv(r"C:\Users\Mayank Bisht\Documents\Data analyst Projects\Zomato_food_chain_analysis_2026\data.csv")

df.head()

# DEEP DIVE ANALYSIS USING PYHTON VISUALIZATION

# 1.Correlation Heatmap

import seaborn as sns
import matplotlib.pyplot as plt

plt.figure()
sns.heatmap(df[["Delivery_Time","Distance","Cost","Rating"]].corr(), annot=True)
plt.title("Correlation Heatmap")
plt.show()

#2. Delivery Time Distribution

plt.figure()
df["Delivery_Time"].hist(bins=30)
plt.title("Delivery Time Distribution")
plt.xlabel("Delivery Time")
plt.ylabel("Frequency")
plt.show()

#3. Cost vs Rating Scatter Plot

plt.figure()
plt.scatter(df["Cost"], df["Rating"])
plt.title("Cost vs Rating")
plt.xlabel("Cost")
plt.ylabel("Rating")
plt.show()

#4. Distance vs Delivery Time Scatter Plot

plt.figure()
plt.scatter(df["Distance"], df["Delivery_Time"])
plt.title("Distance vs Delivery Time")
plt.xlabel("Distance")
plt.ylabel("Delivery Time")
plt.show()

#5. Avg Rating by City

plt.figure()
df.groupby("City")["Rating"].mean().sort_values().plot(kind="barh")
plt.title("Average Rating by City")
plt.show()