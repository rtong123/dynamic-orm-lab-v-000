class Person
  attr_accessor :name, :age, :gender, :location, :birth_city, :nationality, :favorite_ice_cream

  def initialize(name, age, gender, location, birth_city, nationality, favorite_ice_cream)
    @name = name
    @age = age
    @gender = gender
    @location = location
    @birth_city = birth_city
    @nationality = nationality
    @favorite_ice_cream = favorite_ice_cream
  end

  def talk(what_to_say="hello")
    puts what_to_say
  end
end
