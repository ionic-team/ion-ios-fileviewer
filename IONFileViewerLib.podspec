Pod::Spec.new do |spec|
  spec.name                   = 'IONFileViewerLib'
  spec.version                = '1.0.5'

  spec.summary                = 'Library for viewing files in iOS.'
  spec.description            = <<-DESC
  A Swift library for iOS that allows opening files and previewing media files.
  
  The library supports local files, app assets, and remote URLs.
  DESC

  spec.homepage               = 'https://github.com/ionic-team/ion-ios-fileviewer'
  spec.license                = { :type => 'MIT', :file => 'LICENSE' }
  spec.author                 = { 'OutSystems Mobile Ecosystem' => 'rd.mobileecosystem.team@outsystems.com' }
  
  spec.source                 = { :http => "https://github.com/ionic-team/ion-ios-fileviewer/releases/download/#{spec.version}/IONFileViewerLib.zip", :type => "zip" }
  spec.vendored_frameworks    = "IONFileViewerLib.xcframework"

  spec.ios.deployment_target  = '14.0'
  spec.swift_versions         = ['5.0', '5.1', '5.2', '5.3', '5.4', '5.5', '5.6', '5.7', '5.8', '5.9']
end
