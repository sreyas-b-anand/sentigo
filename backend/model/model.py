import pandas as pd
import numpy as np
from sklearn.impute import SimpleImputer
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import OneHotEncoder , FunctionTransformer
from sklearn.compose import ColumnTransformer
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error as mae
from sklearn.model_selection import train_test_split  , cross_val_score
from sklearn.multioutput import MultiOutputRegressor
from xgboost import XGBRegressor
from sklearn.linear_model import SGDClassifier
# Columns to drop
# cols_to_drop = ['Vitamin A','Vitamin B1','Vitamin B2','Vitamin B3','Vitamin B5','Vitamin B6',
#                 'Vitamin B12','Vitamin C','Vitamin D','Vitamin E','Vitamin K','Iron',
#                 'Magnesium','Potassium','Selenium','Zinc']

# Load datasets
#datasets = [pd.read_csv(f'../data/d1/FOOD-DATA-GROUP{i}.csv').drop(columns=cols_to_drop) for i in range(1, 6)]
train_dataset = pd.read_csv('../data/d2/nutrients_csvfile.csv')
#train_dataset = pd.concat(datasets)

# Features and Targets
X = train_dataset[['Food' , 'Grams']]
y = train_dataset[['Calories', 'Fat', 'Carbs', 'Protein']]

# Train-Test Split
X_train, X_val, y_train, y_val = train_test_split(X, y, test_size=0.3, random_state=1)

# Preprocessing for 'Cat and num dtypes'
numerical_transformer = SimpleImputer(strategy='mean')
category_transformer = Pipeline(steps=[
    ('imputer', SimpleImputer(strategy='most_frequent')),
    ('onehot', OneHotEncoder(handle_unknown='ignore'))
])

preprocessor = ColumnTransformer(
    transformers=[
        ('num' , numerical_transformer , ['Grams']),
        ('cat', category_transformer, ['Food'])  
    ]
)

# Model pipeline
pipeline = Pipeline(steps=[
    ('preprocessor', preprocessor),
    ('model', MultiOutputRegressor(
        XGBRegressor(n_estimators=1000 , random_state=1 , learning_rate=0.03 , enable_categorical=True)
    ))
])
print(y_train.isna().sum())
# Train model
pipeline.fit(X_train, y_train)

# Predict
predictions = pipeline.predict(X_train)

# Evaluate
print("Mean Absolute Error:", mae(y_val, predictions))

#d1
#RF - 70.07
#RF - 69.99
#XG - 52.49



#d2



# scores = -1 * cross_val_score(pipeline, X, y,
#                               cv=5,
#                               scoring='neg_mean_absolute_error')

# print("MAE scores:\n", scores)
# print('mean : ' , np.mean(scores))
# print('sd : ' , np.std(scores))
# print('Var : ' , np.var(scores))