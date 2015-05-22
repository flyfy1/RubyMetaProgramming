module M1
  def m1
    puts 'M1#m1'
  end

  def m2
    puts "Hello, #{@name}"
  end
end

class A
  include M1

  def initialize
    @name = 'YY'
  end
end

class B
  extend M1
end

A.new.m1
A.new.m2
B.m1
B.m2


