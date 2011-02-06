ENV["VERSION"] or abort "VERSION= must be specified"
manifest = File.readlines('.manifest').map! { |x| x.chomp! }
require 'wrongdoc'
extend Wrongdoc::Gemspec
name, summary, title = readme_metadata

Gem::Specification.new do |s|
  s.name = %q{mall}
  s.version = ENV["VERSION"].dup
  s.authors = ["#{name} hackers"]
  s.date = Time.now.utc.strftime('%Y-%m-%d')
  s.description = readme_description
  s.email = %q{mall@librelist.org}
  s.extra_rdoc_files = extra_rdoc_files(manifest)
  s.require_paths = %w(ext)
  s.files = manifest
  s.homepage = Wrongdoc.config[:rdoc_url]
  s.summary = summary
  s.rdoc_options = rdoc_options
  s.rubyforge_project = %q{qrp}
  s.test_files = Dir["test/test_*.rb"]
  s.extensions = %w(ext/mall/extconf.rb)
  s.add_development_dependency(%q<wrongdoc>, "~> 1.5")
end
