require "pokapoka/version"
require "github/markdown"
require 'rack'

module Pokapoka
  def self.app
    tpl = '<html>
    <head>
    <link href="https://gist.github.com/assets/application-3e2433f6da817bf23a85587d46e5af5c.css" media="screen, print" rel="stylesheet" />
    <style type="text/css">article{max-width:900px;margin:auto;padding:50px;border:1px solid #ccc;border-top:0;}</style>
    </head>
    <body><article class="markdown-body">BODY</atricle></body>
    </html>'

    app = Proc.new do |env|
      path = env["REQUEST_URI"].sub("/", "").strip
      path = path == "" ? "README.md" : path
      if File.exist?(path)
        [200, {"Content-type" => "text/html"}, tpl.gsub("BODY", GitHub::Markdown.render_gfm(File.read(path))).each_line]
      else
        [404, {}, "stfu".each_line]
      end
    end
  end

  def self.run!
    ::Rack::Handler.default.run app, :Port => 9999
  end
end
