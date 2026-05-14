from flask import Flask, request, render_template_string, redirect, url_for

app = Flask(__name__)

USERNAME = "admin"
PASSWORD = "admin123"

login_page = """
<!DOCTYPE html>
<html>
<head>
    <title>Simple Login</title>
    <style>
        body {
            font-family: Arial;
            background: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-box {
            background: white;
            padding: 30px;
            border-radius: 10px;
            width: 300px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
        }

        button {
            width: 100%;
            padding: 10px;
            margin-top: 15px;
            background: #333;
            color: white;
            border: none;
            cursor: pointer;
        }

        .error {
            color: red;
        }
    </style>
</head>
<body>

<div class="login-box">
    <h2>Login</h2>

    {% if error %}
        <p class="error">{{ error }}</p>
    {% endif %}

    <form method="POST">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>
</div>

</body>
</html>
"""

success_page = """
<!DOCTYPE html>
<html>
<head>
    <title>Logged In</title>
</head>
<body style="font-family: Arial; text-align:center; margin-top:100px;">
    <h1>Logged Successfully ✅</h1>
</body>
</html>
"""


@app.route("/", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")

        if username == USERNAME and password == PASSWORD:
            return redirect(url_for("success"))
        else:
            return render_template_string(login_page, error="Invalid credentials")

    return render_template_string(login_page)


@app.route("/success")
def success():
    return render_template_string(success_page)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
