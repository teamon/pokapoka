require "pokapoka/version"
require "github/markdown"
require 'rack'
require "launchy"

module Pokapoka
  def self.app
    tpl = '<html>
    <head>
    <link href="https://gist.github.com/assets/application-6ee6749e63e8ef98c7d45e7877a8c777.css" media="screen, print" rel="stylesheet" />
    <style type="text/css">article{max-width:900px;margin:auto;padding:50px;border:1px solid #ccc;border-top:0;}</style>
    </head>
    <body><article class="markdown-body">BODY</atricle></body>
    </html>'

    app = Proc.new do |env|
      path = env["PATH_INFO"].sub("/", "").strip

      candidates = if path == ""
        ["README.md", "README.mkdwn", "README.markdown"]
      else
        [path]
      end

      file = candidates.map {|f| File.join(Dir.pwd, f) }.find {|f| File.exists?(f) }

      if file
        [200, {"Content-type" => "text/html"}, tpl.gsub("BODY", GitHub::Markdown.render_gfm(File.read(file))).each_line]
      else
        [404, {}, "File #{path} not found".each_line]
      end
    end
  end

  def self.run!
    Thread.new do
      Launchy.open("http://localhost:9999")
    end

    ::Rack::Handler.default.run app, :Port => 9999
  end
end
