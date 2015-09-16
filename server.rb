require 'socket'

port = 4000
server = TCPServer.open(port)

loop { 
	socket = server.accept

	p socket.peeraddr

	while buffer = socket.gets
		p buffer
		socket.puts 200
	end

	socket.close
}

server.close
