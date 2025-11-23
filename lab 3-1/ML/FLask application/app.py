from flask import Flask, render_template, request
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.datasets import load_breast_cancer
from sklearn.linear_model import LogisticRegression
import numpy as np

app = Flask(__name__)

# ---------- Spam Detection ----------
spam_texts = ["win money now", "free prize", "hello friend", "meet tomorrow"]
spam_labels = ["spam", "spam", "ham", "ham"]
vec = CountVectorizer()
X_spam = vec.fit_transform(spam_texts)
spam_model = MultinomialNB().fit(X_spam, spam_labels)

# ---------- Medical Diagnosis ----------
X_med, y_med = load_breast_cancer(return_X_y=True)
X_med = X_med[:, :2]   # only first 2 features for easy input
med_model = LogisticRegression(max_iter=1000).fit(X_med, y_med)

# ---------- Credit Risk ----------
X_credit = np.array([[50000,5000],[60000,7000],[30000,15000],[25000,20000]])
y_credit = np.array(["low","low","high","high"])
credit_model = LogisticRegression().fit(X_credit, y_credit)

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/spam", methods=["GET","POST"])
def spam():
    pred = None
    if request.method == "POST":
        msg = request.form["msg"]
        pred = spam_model.predict(vec.transform([msg]))[0]
    return render_template("spam.html", pred=pred)

@app.route("/medical", methods=["GET","POST"])
def medical():
    pred = None
    if request.method == "POST":
        f1 = float(request.form["f1"])
        f2 = float(request.form["f2"])
        val = med_model.predict([[f1, f2]])[0]
        pred = "Malignant (cancer)" if val == 1 else "Benign (no cancer)"
    return render_template("medical.html", pred=pred)

@app.route("/credit", methods=["GET","POST"])
def credit():
    pred = None
    if request.method == "POST":
        income = float(request.form["income"])
        loan = float(request.form["loan"])
        pred = credit_model.predict([[income, loan]])[0]
    return render_template("credit.html", pred=pred)

if __name__ == "__main__":
    app.run(debug=True)
