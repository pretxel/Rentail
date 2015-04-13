class MongoController < ApplicationController

def mongoCon

	people = People.new
	people.write_attribute(:gender, "Male")
	people.write_attribute(:name, "Robert")
    people.save
	
end

end