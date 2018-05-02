class Person
  attr_accessor :name, :age, :gender, :location, :birth_city, :nationality, :favorite_ice_cream

  def initialize(attr_hash={})
    attr_hash.each {|attr_name, attr_value| self.send("#{attr_name}=", attr_value)}
  end

  def talk(what_to_say="hello")
    puts what_to_say
  end
end
