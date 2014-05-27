Pod::Spec.new do |s|
  s.name             = "ALGReversedFlowLayout"
  s.version          = "0.1.0"
  s.summary          = "Like a vertical flow layout, but bottom-to-top instead of top-to-bottom."
  s.homepage         = "https://github.com/algal/ALGReversedFlowLayout"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Alexis Gallagher" => "alexis@alexisgallagher.com" }
  s.social_media_url = "http://twitter.com/alexisgallagher"
  s.source           = { :git => "https://github.com/algal/ALGReversedFlowLayout.git", :tag => s.version.to_s }

  s.platform     = :ios, '6.0'
  s.requires_arc = true
  s.source_files = 'Classes', 'Classes/*.{h,m}'
end
