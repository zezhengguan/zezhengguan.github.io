# frozen_string_literal: true

# GitHub Pages 232 pins Ruby Sass 3.7.4 through jekyll-sass-converter 1.5.2.
# On Ruby 3.3+, Ruby Sass mutates Sass values used as Hash keys while iterating
# over that Hash, which raises "hash representation was changed during
# iteration". Iterate over a stable snapshot instead.
if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("3.3")
  require "sass"

  class Sass::Script::Value::Map
    def options=(options)
      super
      value.to_a.each do |key, item|
        key.options = options
        item.options = options
      end
    end
  end
end
