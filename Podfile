# Uncomment the next line to define a global platform for your project
platform :ios, '17.0'

def local
  pod "Netjob", :path => "./Netjob"
end

def complementary
  pod 'SDWebImage'
  pod 'SnapKit'
end

def shared_pods
  inhibit_all_warnings! # ignore all warnings from all pods
  local
  complementary
end


target 'DownAppDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  shared_pods
  # Pods for NC People

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'
    end
  end
end
