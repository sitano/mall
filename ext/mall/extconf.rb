require 'mkmf'

st_r = File.stat('mall.c.erb')
st_c = File.stat('mall.c') rescue nil
if st_c.nil? || st_c.ctime < st_r.ctime
  require 'erb'
  File.open('mall.c+', 'wb') { |fp|
    fp.syswrite(ERB.new(File.read('mall.c.erb')).result)
  }
  File.rename('mall.c+', 'mall.c')
end

have_header('malloc.h') or abort "malloc.h header missing"
have_type('struct mallinfo', 'malloc.h') or warn 'struct mallinfo missing'
dir_config('mall')
create_makefile('mall')
