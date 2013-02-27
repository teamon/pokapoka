require "pokapoka/version"
require "github/markdown"

module Pokapoka
  def self.render(path = 'README.md')
    template = File.read(File.expand_path('../pokapoka/template.html', __FILE__))
    template = template.gsub(/__BODY__/, GitHub::Markdown.render_gfm(File.read(path)))

    template
  end

  def self.html_path(path = 'README.md')
    html = render(path)
    file_path = '/tmp/' + File.basename(path, '.md') + '.html'
    File.open(file_path, 'w') { |file| file.write(html) }

    file_path
  end
end
