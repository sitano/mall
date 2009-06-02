require "test/unit"
require "mall"

class TestMall < Test::Unit::TestCase

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

end
