from app import app

from handlers.User_handler import User_handler

app.run(port=8000, debug=True, reload=True)
