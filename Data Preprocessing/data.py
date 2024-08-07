import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.impute import SimpleImputer

# Sample dataset (replace with your own dataset)
data = {
    'A': [1, 2, np.nan, 4, 5],
    'B': [np.nan, 'dog', 'cat', 'bird', np.nan],
    'C': [10.0, 15.0, 20.0, 25.0, 30.0],
    'D': ['male', 'female', 'male', 'female', 'male']
}

df = pd.DataFrame(data)

# Handle missing values
imputer_num = SimpleImputer(strategy='mean')
imputer_cat = SimpleImputer(strategy='constant', fill_value='missing')
df[['A', 'C']] = imputer_num.fit_transform(df[['A', 'C']])
df[['B']] = imputer_cat.fit_transform(df[['B']])

# Encode categorical variables
le = LabelEncoder()
df['B'] = le.fit_transform(df['B'])
df['D'] = le.fit_transform(df['D'])

# Normalize data
scaler = StandardScaler()
df[['A', 'C']] = scaler.fit_transform(df[['A', 'C']])

# Handle outliers
Q1 = df['A'].quantile(0.25)
Q3 = df['A'].quantile(0.75)
IQR = Q3 - Q1
df = df[~((df['A'] < (Q1 - 1.5 * IQR)) | (df['A'] > (Q3 + 1.5 * IQR)))]

# Split data into training and testing sets
X = df.drop('D', axis=1)
y = df['D']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

print("Training set:")
print(X_train)
print(y_train)
print("Testing set:")
print(X_test)
print(y_test)
