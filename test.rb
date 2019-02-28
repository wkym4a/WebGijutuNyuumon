require 'webrick'

server = WEBrick::HTTPServer.new({
  DocumentRoot:   'dive-into-code-wakayama.c9users.io/test',
  BindAddress:    "0.0.0.0",
  Port:           8080,
  # ここのruby-2.4.0の記述は、自分の環境で ruby -v のコマンドを打ち、出力されたrubyのバージョンを書き込むこと
  # 例えば、 ruby -v のコマンドで2.3.4と出てきたときには、ruby-2.3.4 という記述をする。
  CGIInterpreter: '/usr/local/rvm/rubies/ruby-2.4.0/bin/ruby'
})


server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'top.html')

# WEBrick::HTTPServlet::FileHandlerをWEBrick::HTTPServlet::ERBHandlerに変更する
# 'test.html'を'test.html.erb'に変更する
server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')

server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')

# この一行を追記
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')

#「自家消費を除く」あるいは「品質が悪い」ゴーヤ情報を表示
server.mount('/goya_notJika.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya_notJika.rb')
server.mount('/goya_badQuality.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya_badQuality.rb')

server.start