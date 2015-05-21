def prof_call(blk)
  print 'class:', blk.class,"\n"
  print 'is lambda:', blk.lambda?, "\n"
  print 'blk.call(2):', blk.call(2), "\n"
  print "\n\n"
end

# Proc
inc = Proc.new {|x| x + 1}
prof_call(inc)

b2 = proc {|n| n+1}
prof_call(b2)

# lambda
dec = lambda {|x| x - 1}
prof_call(dec)

# Wrapper over lambda
inc2 = ->(x) {x + 1}
prof_call(inc2)

# Difference
# 1. lambda stress upon arity
# puts 'inc.call(1,2,3)',inc.call(1,2,3)
# puts 'dec.call(1,2,3)',dec.call(1,2,3)

# 2. lambda can be return
lambda_with_return = lambda{|x| return 0 if x.nil?; x+1}
puts lambda_with_return.call(nil)
#    while proc cannot
proc_with_next = proc{|x|  next 0 if x.nil?; x+1}
# this would fail
# proc_with_next = proc{|x|  return 0 if x.nil?; x+1}  
puts proc_with_next.call(nil)


# Curry
abc = proc {|a,b,c| a + b + c}
bc1 = abc.curry[1]
puts bc1.call(2,3)
