Pod::Spec.new do |spec|
  spec.name         = 'NSTViewWarmuper'
  spec.version      = '1.0.1'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/bernikowich/NSTViewWarmuper'
  spec.authors      = { 'Timur Bernikovich' => 'bernikowich@icloud.com' }
  spec.summary      = 'Typesafe collection usage.'
  spec.source       = { :git => 'https://github.com/bernikowich/NSTViewWarmuper.git', :tag => spec.version }
  spec.source_files = 'NSTViewWarmuper/Classes/NSTViewWarmuper.{h,m}'
  spec.module_name  = 'NSTViewWarmuper'
end
