import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt

# Title
st.title(" Streamlit Dashboard")

# Create a small sample dataset
data = {
    'Year': [2020, 2021, 2022, 2023, 2024],
    'Sales': [100, 150, 130, 180, 200],
    'Profit': [20, 30, 25, 40, 50]
}
df = pd.DataFrame(data)

# Show data
st.subheader("Dataset")
st.dataframe(df)

# Show summary
st.subheader("Summary Statistics")
st.write(df.describe())

# Select column to visualize
col = st.selectbox("Select column to visualize", ['Sales', 'Profit'])

# Plot chart
fig, ax = plt.subplots()
ax.plot(df['Year'], df[col], marker='o')
ax.set_xlabel('Year')
ax.set_ylabel(col)
ax.set_title(f"{col} Over Years")
st.pyplot(fig)
