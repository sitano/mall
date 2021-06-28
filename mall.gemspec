manifest = File.exist?('.manifest') ?
  IO.readlines('.manifest').map!(&:chomp!) : `git ls-files`.split("\n")

Gem::Specification.new do |s|
  s.name = %q{mall}
  s.version = (ENV["VERSION"] || '1.0.2').dup
  s.authors = ["#{s.name} hackers"]
  s.description = File.read('README').split("\n\n")[1]
  s.email = %q{mall@yhbt.net}
  s.extra_rdoc_files = IO.readlines('.document').map!(&:chomp!).keep_if do |f|
    File.exist?(f)
  end
  s.require_paths = %w(ext)
  s.files = manifest
  s.homepage = 'https://yhbt.net/mall/'
  s.summary =  'access malloc tuning/reporting functions + glibc extras'
  s.test_files = Dir["test/test_*.rb"]
  s.extensions = %w(ext/mall/extconf.rb)
end
