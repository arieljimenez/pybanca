from models.DB import engine, Base, session
from models import User

Base.metadata.create_all(engine)
session.commit()
