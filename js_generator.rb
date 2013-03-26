class JsGenerator
  def initialize
    @code = []
    @locals = []
  end

  def compile_all(nodes)
    nodes.each do |node|
      node.compile(self)
      emit ";\n"
    end
  end

  def number_literal(value)
    emit value
  end

  def string_literal(value)
    emit "\"" + value + "\""
  end

  def set_local(name, value)
    @locals << name unless @locals.include?(name)
    emit "#{name} = " # name = 1
    value.compile(self)
  end

  def get_local(name)
    emit name # a
  end

  def if(condition, body, else_body)
    emit "if ("
    condition.compile(self)
    emit ") {\n"
    body.compile(self)

    if else_body
      emit "} else {\n"
      else_body.compile(self)
    end

    emit "}"
  end

  # Emit a chunk of Javascript code.
  def emit(code)
    @code << code
  end

  # Called at the end of compilation to assemble all the code generated.
  def assemble
    # var a, b, c;
    "var " + @locals.join(", ") + ";\n" +
    @code.join
  end
end
