# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Go Record' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Go Record
  pod 'CollectionViewPagingLayout'
  pod 'RealmSwift'


  target 'Go RecordTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Go RecordUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end
end
