# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end

if app.development?
  Bundler.require(:development)

  activate :livereload

  require 'lib/reloader'
  Reloader.load_all('helpers')
else
  require 'helpers/dvorak'
end

Dvorak::GameLoader.instance.each_game do |game|
  proxy "/game/#{game.key}.html", "/game.html", locals: {game_key: game.key}, ignore: true
end

set :haml, { escape_attrs: true, escape_html: true, ugly: false }
Haml::TempleEngine.disable_option_validator! # suppress warnings

activate :directory_indexes
activate :sitemap, hostname: 'https://dvorakgamer.com'
