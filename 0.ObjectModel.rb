module M0; end

module M1
  def m
    puts 'M1#m'
  end

  def self.m
    puts '#M1#m'
  end

  include M0
end

module M10; end
module M11; end
class C1; end

class C2 < C1
  def m
    puts 'M2#m'
  end

  def self.m
    puts '#M2#m'
  end

  extend M1

  include M10
  include M11
end

p C2.ancestors
