platform :ios, '10.3'

target 'MuWeather' do
  use_frameworks!
  pod 'Alamofire', '~> 5.0.0-beta.2'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'RealmSwift'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = ‘4.2’
     	    config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
        end
    end
end
