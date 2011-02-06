require "tempfile"
require "test/unit"
require "mall"

class TestMall < Test::Unit::TestCase

  def test_module
    assert_kind_of Module, Mall
  end

  def test_mallinfo
    assert Hash === Mall.info
    Mall.info.each { |key,value|
      assert Symbol === key
      assert Fixnum === value
    }
  end

  def test_mallopt
    Mall.constants.each { |konst|
      rv = Mall.opt(Mall.const_get(konst), 0)
      assert(TrueClass === rv || FalseClass === rv)
    }
  end

  def test_trim
    if Mall.respond_to?(:trim)
      rv = Mall.trim(1024)
      assert(TrueClass === rv || FalseClass === rv)
    else
      warn "Mall.trim not supported"
    end
  end

  def test_xml
    if Mall.respond_to?(:xml)
      str = Mall.xml
      assert_match /<malloc version=/, str

      tmp = []
      assert_equal tmp, Mall.xml(0, tmp)
      assert_match /<malloc version=/, tmp[0]
      assert_equal 1, tmp.size
    else
      warn "Mall.xml not supported"
    end
  end

  def test_dump_stats
    if Mall.respond_to?(:dump_stats)
      olderr = $stderr.dup
      begin
        tmp = Tempfile.new('mall_dump_stats')
        $stderr.sync = tmp.sync = true
        $stderr.reopen(tmp)
        assert_nil Mall.dump_stats
        assert tmp.stat.size != 0
      ensure
        $stderr.reopen(olderr)
      end
    else
      warn "Mall.dump_stats not supported"
    end
  end

end
