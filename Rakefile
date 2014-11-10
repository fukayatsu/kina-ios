# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Kina'
  app.frameworks += %w(CoreLocation CoreBluetooth)
end

Motion::SettingsBundle.setup do |app|
  # A text field. Allows configuration of a string.
  app.text "Your Name", key: "username", default: ""
end
