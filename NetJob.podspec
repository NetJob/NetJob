Pod::Spec.new do |s|
  s.name         = 'NetJob'
  s.version      = '0.1.0'
  s.summary      = 'NetJob'
  s.description  = <<-DESC
                   NetJob
                   DESC
  s.homepage     = 'https://github.com/NetJob/NetJob'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'jasonnam' => 'contact@jasonnam.com' }

  s.source       = { :path => '.' }
  s.source_files = 'Sources/NetJob/**/*.{swift}'
end
