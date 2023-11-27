from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Simple Flask App</title>
    </head>
    <body>
        <header>
            <h1>Hello from KRISHAN LAL!</h1>
        </header>

        <section>
            <p>THANKS FOR VISTING TO MY PAGE.</p>
        </section>
    </body>
    </html>
    """

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=80, debug=True)
