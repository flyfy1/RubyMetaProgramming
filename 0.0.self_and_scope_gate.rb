# Self
class A

  def self.me
    self
  end

  def me
    self
  end
end

puts A.me
puts a = A.new.me


# instance_eval
A.instance_eval do
  def hello
    puts 'hello from (A.instance_eval)'
  end
end

A.hello

a.instance_eval do
  def hello
    puts 'hello from (a.instance_eval)'
  end
end

puts "singleton methods: ", a.singleton_methods
a.hello

class B
end


# Note: give a example of add_method_to(clz,n) , which is not working
# class_eval
def add_method_to(a_class)
  a_class.class_eval do
    def m; 'Hello!'; end
  end
end

add_method_to String


def a.m2
  puts 'defined as singleton method'
end
puts "singleton methods: ", a.singleton_methods
