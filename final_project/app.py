import os

from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session
from flask_session import Session
from tempfile import mkdtemp
from werkzeug.security import check_password_hash, generate_password_hash
import time
from datetime import datetime

from helpers import apology, login_required, lookup, usd

# Configure application
app = Flask(__name__)

# Ensure templates are auto-reloaded
app.config["TEMPLATES_AUTO_RELOAD"] = True

# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///sudoku.db")

@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


@app.route("/")
@login_required
def index():
    """Show portfolio of stocks"""
    # hist = db.execute(
    #     "SELECT symbol, name, SUM(quantity) as quantity, price, cash FROM transactions WHERE users_id = ? GROUP BY name ORDER BY time ASC", session["user_id"])
    # print(hist)
    return render_template("index.html")


@app.route("/game", methods=["GET", "POST"])
@login_required
def game():
    if request.method == "POST":
        dict_res = {}
        for key, val in request.form.items():
            dict_res[key]=val

        json_answ = db.execute("SELECT * FROM answer_games WHERE COD_MATRIZ = ?",
                               dict_res['game_number'])
        finished = True
        life = int(dict_res['life'])
        for key in dict_res:
            print('key: ', key)
            print('dict[key]: ', dict_res[key])
            if key!='game_number' and key!='life':
                if dict_res[key]!='':
                    print('eu passei aqui', dict_res[key])
                    if int(json_answ[int(key[2])-1][str(key[:2])]) == int(dict_res[key]):
                        db.execute("UPDATE current_games SET {}=? WHERE ORDEM=? AND COD_MATRIZ=? AND USERS_ID=?".format(
                        key[:2]), dict_res[key], key[2], dict_res['game_number'], session["user_id"])
                    else:
                        db.execute("UPDATE current_games SET {}=NULL WHERE ORDEM=? AND COD_MATRIZ=? AND USERS_ID=?".format(
                            key[:2]), key[2], dict_res['game_number'], session["user_id"])
                        life -= 1
                        finished = False
                else:
                    finished = False

        if finished:
            flash('Vc ganhou campeão!!!', 'success')
            db.execute("DELETE FROM current_games WHERE USERS_ID = ? AND COD_MATRIZ = ?",
                       session["user_id"], dict_res['game_number'])
            return redirect("/")

        elif life <= 0:
            flash('Vc perdeu campeão!!!', 'error')
            db.execute("DELETE FROM current_games WHERE USERS_ID = ? AND COD_MATRIZ = ?",
                       session["user_id"], dict_res['game_number'])
            return redirect("/")

        json_res = db.execute( "SELECT * FROM current_games WHERE COD_MATRIZ = ? AND USERS_ID = ?", dict_res['game_number'], session["user_id"])
        print(dict_res)
        return render_template("game.html", res=json_res, opt=life)
    else:
        return render_template("game.html")

@app.route("/history")
@login_required
def history():
    """Show history of transactions"""
    # return render_template("history.html", res=hist)


@app.route("/new", methods=["GET", "POST"])
@login_required
def new():
    if request.method == "POST":
        level = request.form.get("level")
        numGame = request.form.get("#game")
        json_res = db.execute("SELECT * FROM new_games WHERE COD_MATRIZ= ?", numGame)
        if not db.execute("SELECT * FROM current_games WHERE COD_MATRIZ= ? AND USERS_ID = ?", numGame, session["user_id"]):
            life = 3
            for order in range(9):
                db.execute("INSERT INTO current_games (USERS_ID, COD_MATRIZ, ORDEM, N1, N2, N3, N4, N5, N6, N7, N8, N9) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", session["user_id"], numGame, json_res[order]['ORDEM'], json_res[order]['N1'], json_res[order]['N2'], json_res[order]['N3'], json_res[order]['N4'], json_res[order]['N5'], json_res[order]['N6'], json_res[order]['N7'], json_res[order]['N8'], json_res[order]['N9'])
            json_res = db.execute("SELECT * FROM current_games WHERE COD_MATRIZ= ? AND USERS_ID = ?", numGame, session["user_id"])
            return render_template("game.html", res=json_res, opt=life)
        else:
            flash('vc já criou esse game amigão','error')
            return render_template("game.html", res=json_res, opt=life)
        # updating current games with new game


    else:
        game_lst = db.execute("SELECT DISTINCT(COD_MATRIZ) FROM new_games")
        game_lst = [int(dict_res['COD_MATRIZ']) for dict_res in game_lst]
        print(game_lst)
        return render_template("new.html",game_lst=game_lst)


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 400)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 400)

        # Query database for username
        rows = db.execute("SELECT * FROM users WHERE username = ?", request.form.get("username"))

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], request.form.get("password")):
            return apology("invalid username and/or password", 400)

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")


@app.route("/register", methods=["GET", "POST"])
def register():
    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        """Register user"""
        username = request.form.get("username")
        hash = generate_password_hash(request.form.get("password"))
        confirmation = request.form.get("confirmation")

        if not username:
            return apology("must provide username to registrated", 400)

        if not hash:
            return apology("must provide password to registrated", 400)

        if not confirmation:
            return apology("must provide passowrd again to registrated", 400)

        if confirmation != request.form.get("password"):
            return apology("passwords mismatched", 400)

        user_list = [i['username'] for i in db.execute("SELECT username FROM users")]
        if username in user_list:
            return apology("username already registrated", 400)
        db.execute("INSERT INTO users (username, hash) VALUES (?, ?)", username, hash)

        # Query database for username
        rows = db.execute("SELECT * FROM users WHERE username = ?", request.form.get("username"))

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")
        # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("register.html")