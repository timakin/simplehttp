require 'socket'


RESOURCE_ROOT = './public'
HTTP_METHODS = ['GET', 'POST', 'PUT', 'DELETE']


class HTTPServer
  def initialize
    @path = '/index.html'
    @port = 4000
    @server = TCPServer.open(@port)
  end

  def requested_path(buffer)
    @path = (buffer =~ /^GET/) ? RESOURCE_ROOT + '/index.html' : @path
  end

  def path_init
    @path = '/index.html'
  end

  def response_header(bytesize)
    "HTTP/1.1 200 OK\r\n" +
    "Content-Type: text/plain\r\n" +
    "Content-Length: #{bytesize}\r\n"
  end

  def run
    loop do
      socket = @server.accept   

      begin
        while buffer = socket.gets
          p buffer
          @path = requested_path(buffer)
          content = @path
          socket.puts response_header(content.bytesize)
          socket.puts "\r\n"
          socket.puts content
        end
        path_init
      rescue
        socket.close
      end
    end
    @server.close
  end
end

http = HTTPServer.new
http.run