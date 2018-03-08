# coding=utf-8
import datetime

from sqlalchemy import Column, Integer, String, DateTime
from Database import Base, Session

from werkzeug import generate_password_hash, check_password_hash


class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True)
    fristname = Column(String(64))
    lastname = Column(String(64))
    username = Column(String(16), unique=True)
    password = Column(String(93))
    email = Column(String(64), unique=True)
    created_at = Column(DateTime, default=datetime.date.today())

    def __init__(self, firstname, lastname, username, password, email):
        self.firstname = firstname.title()
        self.lastname = lastname.title()
        self.username = username
        self.set_password(password)
        self.email = email.lower()

    def __repr__(self):
        return "< User(fistname='%s', lastname='%s', username='%s', password='%s',\
                       email='%s', created_at='%s') >" % (self.fristname, self.lastname, self.username,
                                                          self.password, self.email, self.created_at)

    def set_password(self, password):
        self.password = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.pwdhash, password)


def get_all_users():
    session = Session()

    json = {}
    users = session.query(User).all()

    for user in users:
        json[user.username] = user.lastname

    session.close()
    return json
