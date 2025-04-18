import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.model_selection import train_test_split
from sklearn.multioutput import MultiOutputRegressor
from xgboost import XGBRegressor
from sklearn.metrics import mean_absolute_error as mae, r2_score as r
import numpy as np
# Drop unwanted columns
cols_to_drop = ['Vitamin A', 'Vitamin B1', 'Vitamin B2', 'Vitamin B3', 'Vitamin B5', 'Vitamin B6',
                'Vitamin B12', 'Vitamin C', 'Vitamin D', 'Vitamin E', 'Vitamin K', 'Iron',
                'Magnesium', 'Potassium', 'Selenium', 'Zinc']

# Load datasets
train_dataset = pd.read_csv('../data/d2/nutrients_csvfile.csv')
# train_dataset = pd.concat(train_dataset1, ignore_index=True)
train_dataset.replace('t' , np.nan , inplace=True)
train_dataset.replace('\'t' , np.nan , inplace=True)
train_dataset.replace('t\'' , np.nan , inplace=True)
train_dataset = train_dataset.dropna(subset=['Calories', 'Fat', 'Carbs', 'Protein'])

# Prepare inputs and labels
X_raw = train_dataset['Food']
y = train_dataset[['Calories', 'Fat', 'Carbs', 'Protein']]
# TF-IDF transformation
vectorizer = TfidfVectorizer()
X_vec = vectorizer.fit_transform(X_raw)

# Split data
X_train, X_val, y_train, y_val = train_test_split(X_vec, y, test_size=0.3, random_state=1)

# Model
model = MultiOutputRegressor(XGBRegressor(n_estimators=1500,n_jobs=-1 ,  max_depth=10, random_state=1 , learning_rate=0.3 , enable_categorical=True))
model.fit(X_train, y_train)

# Evaluate
predictions = model.predict(X_val)
print("MAE:", mae(y_val, predictions))
print("R2:", r(y_val, predictions))
