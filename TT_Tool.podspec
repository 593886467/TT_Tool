#
# Be sure to run `pod lib lint TT_Tool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TT_Tool'
  s.version          = '0.0.1'
  s.summary          = '一些通用的工具 和 UI'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  TODO: TT_CommentKit 适用用于现有框架的通用视图规范
        TT_CommentTool 动画 和 通用工具
       DESC

  s.homepage         = 'https://github.com/593886467/TT_Tool'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fantengteng' => '593886467@qq.com' }
  s.source           = { :git => 'https://github.com/593886467/TT_Tool.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.requires_arc = true

  s.subspec 'TT_CommentKit' do |sp|
    sp.source_files = 'TT_Tool/Classes/TT_CommentKit/**/*'
    sp.dependency 'TT_Tool/TT_CommnetMaco'
    sp.dependency 'TT_Tool/TT_CommentNetWork'
    sp.dependency 'TT_Tool/TT_CommentCat'
    sp.dependency 'TT_Tool/TT_CommentTool'
    sp.dependency 'MJRefresh'
  end
  
  s.subspec 'TT_CommentTool' do |sp|
    sp.source_files = 'TT_Tool/Classes/TT_CommentTool/**/*'
    sp.dependency 'TT_Tool/TT_CommnetMaco'
    sp.dependency 'TT_Tool/TT_CommentNetWork'
    sp.dependency 'TT_Tool/TT_CommentCat'
    sp.dependency 'MBProgressHUD'
  end
  
  s.subspec 'TT_CommentCat' do |sp|
    sp.source_files = 'TT_Tool/Classes/TT_CommentCat/**/*'
    sp.dependency 'YYCategories'
  end
  
  s.subspec 'TT_CommentNetWork' do |sp|
    sp.source_files = 'TT_Tool/Classes/TT_CommentNetWork/**/*'
    sp.dependency 'YTKNetwork'
  end

  s.subspec 'TT_CommnetMaco' do |sp|
    sp.source_files = 'TT_Tool/Classes/TT_CommnetMaco/**/*'
  end
  
end
