from japronto import Application
from models.User import User
from models.DB import Base, session, engine


def hello(request):
    u = User(firstname='ariel',
             lastname='jimenez',
             username='ajimenddedeeaza',
             password='aridddccdel',
             email='a@xkeddece')

    session.add(u)
    session.commit()

    return request.Response(json={'greetings': u.password})


app = Application()

app.router.add_route('/', hello)

app.run(port=8000, debug=True, reload=True)
