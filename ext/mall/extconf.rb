require 'mkmf'

have_header('malloc.h') or abort "malloc.h header missing"
have_type('struct mallinfo', 'malloc.h') or abort 'struct mallinfo missing'
have_func('malloc_trim', 'malloc.h')
have_func('malloc_stats', 'malloc.h')
have_func('malloc_info', 'malloc.h')

PATH=File.expand_path(File.dirname(__FILE__))
system("erb #{PATH}/mall.c.erb > mall.c")

create_makefile('mall')
