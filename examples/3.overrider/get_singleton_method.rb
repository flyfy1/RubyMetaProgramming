class C
  def self.nani
    puts 'nani'
  end
end

puts C.singleton_method('nani')
