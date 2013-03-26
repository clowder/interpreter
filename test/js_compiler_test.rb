require File.dirname(__FILE__) + '/test_helper'
require "compiler"
require "js_generator"

class JsCompilerTest < Test::Unit::TestCase
  def setup
    @compiler = Compiler.new(JsGenerator)
  end

  def test_assign
    assert_equal "var a, b;\na = 1;\nb = 2;\n", @compiler.compile("a=1; b=2")
  end

  def test_get_local
    assert_equal "var a;\na = 1;\na;\n", @compiler.compile("a=1; a")
  end

  def test_if
    code = <<CODE
a = 1
if a
  b = 2
end
CODE

    js = <<JS
var a, b;
a = 1;
if (a) {
b = 2;
};
JS

    assert_equal js, @compiler.compile(code)
  end

  def test_if_else
    code = <<CODE
a = 1
if a
  b = 2
else
  b = 3
end
CODE

    js = <<JS
var a, b;
a = 1;
if (a) {
b = 2;
} else {
b = 3;
};
JS

    assert_equal js, @compiler.compile(code)
  end
end
