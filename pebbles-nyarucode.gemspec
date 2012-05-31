# -*- encoding: utf-8 -*-
require './lib/pebbles/nyarucode'

Gem::Specification.new do |gem|
  gem.authors       = ["H.Hiro(Maraigue)"]
  gem.email         = ["main@hhiro.net"]
  gem.description   = %{This program converts a ruby code into "U-! Nya-!" ruby code (from "Haiyore! Nyaruko-san"). As a result, your program is shown by many emoticons.}
  gem.summary       = %{To convert a ruby code into "U-! Nya-!" ruby code (from "Haiyore! Nyaruko-san")}
  gem.homepage      = "http://github.com/maraigue/nyarucode-ruby"

  gem.executables   = Dir.glob("bin/*").map{ |x| File.basename(x) }
  gem.test_files    = Dir.glob("spec/*")
  gem.name          = "pebbles-nyarucode"
  gem.require_paths = ["lib"]
  gem.version       = Pebbles::Nyarucode::VERSION
end

