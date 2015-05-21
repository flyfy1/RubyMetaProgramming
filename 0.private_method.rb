class A
  def caller
    self.call
  end

  private 
  def call
    puts "I'm calling"
  end

  def self.clz_call
    puts 'calling from clz'
  end
end

# A.new.caller

A.new.instance_eval do
  call
end

A.instance_eval do
  clz_call
end

