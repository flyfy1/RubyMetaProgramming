module Missing
  # Method Missing is a class method
  def method_missing(method_sym, *arguments, &block)
    puts "method_missing:#{method_sym}, #{arguments}, hasBlock: #{block}"
  end

  def const_missing(cons)
    puts "Checking cons for: ", cons.to_s
  end
end

class A
  extend Missing
  include Missing
end

print 'ancestors: ', A.ancestors,"\n"
puts "*missing:,#{A.methods.grep /missing/}"

puts A::BB
A.new.nani?(1,2,3)
A.nani?

class Foo
  def self.const_missing(name)
    'Foo Lala::' + name.to_s # return the constant name as Symbol
  end
end

puts "*missing:,#{Foo.methods.grep /missing/}"

puts Foo::UNDEFINED_CONST    #=> :UNDEFINED_CONST: symbol returned

class C
end
