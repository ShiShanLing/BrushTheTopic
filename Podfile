target 'BrushTheTopic' do
inhibit_all_warnings!
use_frameworks!
platform :ios, '14.0'
pod 'HandyJSON'
pod 'Charts'
pod 'WCDB.swift'
post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
end

