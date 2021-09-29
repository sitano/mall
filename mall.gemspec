manifest = File.exist?('.manifest') ?
  IO.readlines('.manifest').map!(&:chomp!) : `git ls-files`.split("\n")

Gem::Specification.new do |s|
  s.name = %q{mall}
  s.version = (ENV["VERSION"] || '1.0.3').dup
  s.authors = ["#{s.name} hackers (mall@yhbt.net)", "Ivan Prisyazhnyy"]
  s.description = File.read('README').split("\n\n")[1] + "\n\n" +
    "1.0.3 fixes minor issues to be compatible with gem install and rake."
  s.email = ["john.koepi@gmail.com", "mall@yhbt.net"]
  s.extra_rdoc_files = IO.readlines('.document').map!(&:chomp!).keep_if do |f|
    File.exist?(f)
  end
  s.require_paths = %w(ext)
  s.files = manifest
  s.homepage = 'https://github.com/sitano/mall'
  s.summary =  'access malloc tuning/reporting functions + glibc extras. linux only.'
  s.test_files = Dir["test/test_*.rb"]
  s.extensions = %w(ext/mall/extconf.rb)
  s.licenses = ["LGPL"]
end
