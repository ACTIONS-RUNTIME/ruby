# VM_CALL_OPT_SEND + VM_METHOD_TYPE_ATTRSET
assert_equal '1', %q{
  class Foo
    attr_writer :foo

    def bar
      send(:foo=, 1)
    end
  end

  Foo.new.bar
}

# VM_CALL_OPT_SEND + OPTIMIZED_METHOD_TYPE_CALL
assert_equal 'foo', %q{
  def bar(&foo)
    foo.send(:call)
  end

  bar { :foo }
}

# VM_CALL_OPT_SEND + OPTIMIZED_METHOD_TYPE_STRUCT_AREF
assert_equal 'bar', %q{
  def bar(foo)
    foo.send(:bar)
  end

  bar(Struct.new(:bar).new(:bar))
}
