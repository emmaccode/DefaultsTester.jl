module DefaultsTester
using Toolips
using ToolipsSession
using ToolipsDefaults

function home(c::Connection)
    write!(c, DOCTYPE())
    write!(c, h("intro", 2, text = "welcome to a toolips defaults demo app!"))
    swiper = a("swiper", href = "/swipe")
    push!(swiper, li("swipething", text = "swipe demonstration"))
    write!(c, swiper)
    mycont = div("mycont")
    push!(mycont, h("myhead", 1, text = "test1"))
    othercont = div("mcont")
    push!(othercont, h("mhead", 1, text = "test2"))
    tv = ToolipsDefaults.tabbedview(c, "mytabs", [mycont, othercont])
    write!(c, tv)
end

swipe = route("/swipe") do c::Connection
    sm = ToolipsDefaults.SwipeMap()
    swipe_identifier = h("swipeid", 1, text = "none", align = "center")
    style!(swipe_identifier, "margin-top" => 40percent, "font-size" => 25pt)
    bod = body("mybody")
    bind!(c, sm, "right") do cm::ComponentModifier
        set_text!(cm, swipe_identifier, "right")
        style!(cm, bod, "background-color" => "black")
    end
    bind!(c, sm, "left") do cm::ComponentModifier
        set_text!(cm, swipe_identifier, "left")
        style!(cm, bod, "background-color" => "orange")
    end
    bind!(c, sm, "up") do cm::ComponentModifier
        set_text!(cm, swipe_identifier, "up")
        style!(cm, bod, "background-color" => "blue")
    end
    bind!(c, sm, "down") do cm::ComponentModifier
        set_text!(cm, swipe_identifier, "down")
        style!(cm, bod, "background-color" => "pink")
    end
    bind!(c, sm)
    push!(bod, swipe_identifier)
    style!(bod, "transition" => 5seconds)
    write!(c, bod)
end

fourofour = route("404") do c
    write!(c, p("404message", text = "404, not found!"))
end

routes = [route("/", home), fourofour, swipe]
extensions = Vector{ServerExtension}([Logger(), Files(), Session(["/", "/swipe"])])
"""
start(IP::String, PORT::Integer, ) -> ::ToolipsServer
--------------------
The start function starts the WebServer.
"""
function start(IP::String = "127.0.0.1", PORT::Integer = 8000)
     ws = WebServer(IP, PORT, routes = routes, extensions = extensions)
     ws.start(); ws
end
end # - module
