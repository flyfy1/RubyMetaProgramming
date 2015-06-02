module M
  def self.append_features(base)
    puts 'appending features'
  end

  def abc
    puts 'M#abc'
  end
end

class A
  include M
end

p A.ancestors
