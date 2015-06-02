module Missing
  def self.included(clz)
    clz.extend(ClassMethods)
  end

  module ClassMethods
    def const_missing(cons)
      puts "Checking cons for: ", cons.to_s
    end
   
    # Method Missing is a class method
    def method_missing(method_sym, *arguments, &block)
      puts "method_missing:#{method_sym}, #{arguments}, hasBlock: #{block}"
    end
  end
 
  # Method Missing is a class method
  def method_missing(method_sym, *arguments, &block)
    puts "method_missing:#{method_sym}, #{arguments}, hasBlock: #{block}"
  end
end

class A
  include Missing
end

print 'ancestors: ', A.ancestors,"\n"
puts "*missing:,#{A.methods.grep /missing/}"

puts A::BB
A.new.nani?(1,2,3) {|a| puts "a is good: #{a}"}
A.nani?
