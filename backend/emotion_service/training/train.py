import os
import re
import time
import joblib
import pandas as pd
import numpy as np

from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import (
    accuracy_score,
    f1_score,
    classification_report,
    confusion_matrix,
    ConfusionMatrixDisplay
)

import matplotlib.pyplot as plt


# ============================================================
# 1. LOAD DATASET
# ============================================================

DATASET_PATH = "/kaggle/input/datasets/sreyasbanand/fddset/final_dataset.csv"

df = pd.read_csv(DATASET_PATH)

print("=" * 60)
print("DATASET")
print("=" * 60)

print("Shape:", df.shape)
print("Columns:", df.columns.tolist())


# ============================================================
# 2. BASIC CLEANING
# ============================================================

df = df.dropna(
    subset=["text", "emotion"]
).copy()

df["text"] = df["text"].astype(str)
df["emotion"] = df["emotion"].astype(str)


# Remove exact duplicate rows
df = df.drop_duplicates(
    subset=["text", "emotion"]
).reset_index(drop=True)

print("\nAfter removing exact duplicates:")
print("Shape:", df.shape)


# ============================================================
# 3. TEXT CLEANING
# ============================================================

def clean_text(text):

    text = str(text).lower()

    # URLs
    text = re.sub(
        r"http\S+|www\S+|https\S+",
        " ",
        text
    )

    # Mentions
    text = re.sub(
        r"@\w+",
        " ",
        text
    )

    # Hashtags -> keep word
    text = re.sub(
        r"#(\w+)",
        r"\1",
        text
    )

    # HTML
    text = re.sub(
        r"<.*?>",
        " ",
        text
    )

    # Normalize repeated characters
    # sooo -> soo
    text = re.sub(
        r"(.)\1{2,}",
        r"\1\1",
        text
    )

    # Normalize whitespace
    text = re.sub(
        r"\s+",
        " ",
        text
    )

    return text.strip()


print("\nCleaning text...")

start = time.time()

df["clean_text"] = df["text"].apply(
    clean_text
)

print(
    f"Cleaning completed in "
    f"{time.time() - start:.2f} seconds"
)


# Remove empty texts
df = df[
    df["clean_text"].str.len() > 0
].reset_index(drop=True)


# ============================================================
# 4. CLASS DISTRIBUTION
# ============================================================

print("\n" + "=" * 60)
print("CLASS DISTRIBUTION")
print("=" * 60)

print(
    df["emotion"].value_counts()
)


# ============================================================
# 5. TRAIN / TEST SPLIT
# ============================================================

X = df["clean_text"]
y = df["emotion"]

X_train, X_test, y_train, y_test = train_test_split(
    X,
    y,
    test_size=0.20,
    random_state=42,
    stratify=y
)

print("\nTraining samples:", len(X_train))
print("Testing samples:", len(X_test))


# ============================================================
# 6. TF-IDF
# ============================================================

print("\n" + "=" * 60)
print("TF-IDF")
print("=" * 60)

vectorizer = TfidfVectorizer(
    max_features=100000,
    ngram_range=(1, 2),
    min_df=2,
    max_df=0.95,
    sublinear_tf=True,
    strip_accents="unicode"
)

start = time.time()

X_train_tfidf = vectorizer.fit_transform(
    X_train
)

print(
    "\nTraining feature shape:",
    X_train_tfidf.shape
)

print(
    f"TF-IDF fitting time: "
    f"{time.time() - start:.2f} seconds"
)


start = time.time()

X_test_tfidf = vectorizer.transform(
    X_test
)

print(
    "Testing feature shape:",
    X_test_tfidf.shape
)

print(
    f"Transformation time: "
    f"{time.time() - start:.2f} seconds"
)


# ============================================================
# 7. LOGISTIC REGRESSION
# ============================================================

print("\n" + "=" * 60)
print("LOGISTIC REGRESSION")
print("=" * 60)

model = LogisticRegression(
    C=1.0,
    max_iter=3000,
    solver="liblinear",
    class_weight=None,
    random_state=42
)

print("\nTraining...")

start = time.time()

model.fit(
    X_train_tfidf,
    y_train
)

print(
    f"Training completed in "
    f"{time.time() - start:.2f} seconds"
)


# ============================================================
# 8. PREDICTION
# ============================================================

print("\nPredicting...")

start = time.time()

y_pred = model.predict(
    X_test_tfidf
)

print(
    f"Prediction completed in "
    f"{time.time() - start:.2f} seconds"
)


# ============================================================
# 9. EVALUATION
# ============================================================

accuracy = accuracy_score(
    y_test,
    y_pred
)

macro_f1 = f1_score(
    y_test,
    y_pred,
    average="macro"
)

weighted_f1 = f1_score(
    y_test,
    y_pred,
    average="weighted"
)


print("\n" + "=" * 60)
print("RESULTS")
print("=" * 60)

print(
    f"\nTest Accuracy: "
    f"{accuracy * 100:.2f}%"
)

print(
    f"Test Macro F1: "
    f"{macro_f1:.4f}"
)

print(
    f"Test Weighted F1: "
    f"{weighted_f1:.4f}"
)


# ============================================================
# 10. CLASSIFICATION REPORT
# ============================================================

print("\n" + "=" * 60)
print("CLASSIFICATION REPORT")
print("=" * 60)

print(
    classification_report(
        y_test,
        y_pred,
        digits=4,
        zero_division=0
    )
)


# ============================================================
# 11. CONFUSION MATRIX
# ============================================================

labels = sorted(
    df["emotion"].unique()
)

cm = confusion_matrix(
    y_test,
    y_pred,
    labels=labels
)

fig, ax = plt.subplots(
    figsize=(12, 10)
)

disp = ConfusionMatrixDisplay(
    confusion_matrix=cm,
    display_labels=labels
)

disp.plot(
    ax=ax,
    xticks_rotation=45,
    values_format="d"
)

plt.title(
    "Sentigo Emotion Classification - Confusion Matrix"
)

plt.tight_layout()
plt.show()


# ============================================================
# 12. SAVE MODEL + VECTORIZER
# ============================================================

MODEL_DIR = "/kaggle/working/models"

os.makedirs(
    MODEL_DIR,
    exist_ok=True
)

model_path = os.path.join(
    MODEL_DIR,
    "sentigo_emotion_lr.joblib"
)

vectorizer_path = os.path.join(
    MODEL_DIR,
    "sentigo_tfidf.joblib"
)

joblib.dump(
    model,
    model_path
)

joblib.dump(
    vectorizer,
    vectorizer_path
)


# ============================================================
# 13. SAVE COMPLETE PIPELINE
# ============================================================

pipeline = {
    "model": model,
    "vectorizer": vectorizer,
    "classes": labels
}

pipeline_path = os.path.join(
    MODEL_DIR,
    "sentigo_emotion_pipeline.joblib"
)

joblib.dump(
    pipeline,
    pipeline_path
)


# ============================================================
# 14. SAMPLE PREDICTIONS
# ============================================================

def predict_emotion(text):

    cleaned = clean_text(text)

    features = vectorizer.transform(
        [cleaned]
    )

    prediction = model.predict(
        features
    )[0]

    probabilities = model.predict_proba(
        features
    )[0]

    class_index = list(
        model.classes_
    ).index(prediction)

    confidence = probabilities[
        class_index
    ]

    return prediction, confidence


examples = [
    "I am extremely happy today!",
    "I feel really sad and lonely",
    "I am so angry right now",
    "I am worried about everything",
    "I am excited to see my friends",
    "I don't really feel anything today",
    "I absolutely love this!",
    "This is the worst thing ever",
    "I can't believe what just happened!"
]

print("\n" + "=" * 60)
print("SAMPLE PREDICTIONS")
print("=" * 60)

for text in examples:

    emotion, confidence = predict_emotion(
        text
    )

    print(f"\nText: {text}")
    print(f"Emotion: {emotion}")
    print(
        f"Confidence: "
        f"{confidence * 100:.2f}%"
    )



print("\n" + "=" * 60)
print("DONE")
print("=" * 60)

print(
    f"\nAccuracy: "
    f"{accuracy * 100:.2f}%"
)

print(
    f"Macro F1: "
    f"{macro_f1:.4f}"
)

print(
    f"Weighted F1: "
    f"{weighted_f1:.4f}"
)

print(
    f"\nModel: {model_path}"
)

print(
    f"Vectorizer: {vectorizer_path}"
)

print(
    f"Complete pipeline: {pipeline_path}"
)