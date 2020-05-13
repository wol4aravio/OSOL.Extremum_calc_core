using Bukdu

struct RESTController <: ApplicationController
    conn::Conn
end

function index(c::RESTController)
    return render(JSON, "Hello World")
end

function health(c::RESTController)
    return render(JSON, "OK")
end

routes() do
    get("/",       RESTController, index)
    get("/health", RESTController, health)
end

Bukdu.start(8080)
