class MyC
  n = 1

  # Accessing local vars
  define_method :my_m do |my_arg|
    my_arg * n
  end

  def abc
    puts 'abc'
  end

end

puts MyC.new.my_m(10)

class MyC
  undef_method :abc
end

# MyC.new.abc => would raise no method error
