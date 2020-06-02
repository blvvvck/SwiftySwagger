Pod::Spec.new do |spec|
  spec.name = 'SwiftySwagger'
  spec.version = `1.0.0`
  spec.summary = 'The Swift code generator for OpenAPI / Swagger specifications.'
  spec.homepage = 'https://github.com/blvvvck/SwiftySwagger/'
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.author = { 'Rinat Muhammetzyanov' => 'theblvvvck@gmail.com' }

  spec.source = {
    http: "https://github.com/blvvvck/SwiftySwagger/releases/download/#{spec.version}/swiftyswagger-#{spec.version}.zip"
  }

  spec.preserve_paths = '*'
  spec.exclude_files = '**/file.zip'
end
