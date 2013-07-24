using HttpServer

http = HttpHandler() do req::Request, res::Response
    Response( ismatch(r"^/hello/",req.resource) ? string("Hello ", split(req.resource,'/')[3], "!") : 404 )
end

http.events["listen"]  = ( port )        -> println("Listening on $port...")
http.events["connect"] = ( client ) 	 -> println("$(client.id) connect")
# http.events["write"]   = ( client, res ) -> println("$(client.id): write")
# http.events["close"]   = ( client ) 	 -> println("$(client.id): close")
http.events["error"]   = ( client, err ) -> println( err )

server = Server( http )
run( server, 8000 )
