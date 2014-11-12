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
  app.identifier = 'com.fukayatsu.kinadev'
  app.codesign_certificate = "iPhone Developer: Atsuo Fukaya (372MDSS245)"
  app.provisioning_profile = 'vender/fukayatsu_dev.mobileprovision'

  app.info_plist['NSLocationAlwaysUsageDescription']    = 'We need your location in order to list who is near the beacon'
  app.info_plist['NSLocationWhenInUseUsageDescription'] = 'We need your location in order to list who is near the beacon'

end

Motion::SettingsBundle.setup do |app|
  # A text field. Allows configuration of a string.
  app.text "Your Name", key: "username", default: ""
end
