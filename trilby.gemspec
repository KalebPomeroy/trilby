Gem::Specification.new do |s|
  s.name        = 'trilby'
  s.version     = '0.1'
  s.date        = '2013-03-04'
  s.summary     = "Trilby"
  s.description = "Because its on top of sinatra"
  s.authors     = ["Kaleb Pomeroy"]
  s.email       = 'trilby@pomeroytx.com'
  s.files       = ["lib/trilby.rb", "lib/trilby/controller.rb"]
  s.homepage    = 'https://github.com/KalebPomeroy/trilby'

  
  s.add_runtime_dependency  'sinatra'
end