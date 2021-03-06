require 'pry'
require_relative 'animal'
require_relative 'client'
require_relative 'shelter'

SEPARATOR = "-" * 50
shelter = Shelter.new

# Print animal details
def display_animals(shelter)
  animals = shelter.get_animals
  animals.each do |animal|
    puts "Name: #{animal.get_name}"
    puts "Age: #{animal.get_age}"
    puts "Gender: #{animal.get_gender}"
    puts "Species: #{animal.get_species}"
    puts ""
  end
  puts "#{animals.length} #{animals.length != 1 ? 'animals' : "animal"}."
end

# Print client details
def display_clients(shelter)
  clients = shelter.get_clients
  clients.each do |client|
    puts "Name: #{client.get_name}"
    puts "Children: #{client.get_no_of_children}"
    puts "Age: #{client.get_age}"
    # Display pets owned by client
    puts "Pets:"
    client.get_pets.each do |pet|
      puts "    * #{pet.get_name}"
    end
    puts ""
  end
  puts "#{clients.length} #{clients.length != 1 ? 'clients' : 'client'}"
end

# Prompt user for animal details and
# add new animal to shelter
def add_animal(shelter)
  # Get details for new animal
  print "Animal name: "
  name = gets.chomp
  print "Age: "
  age = gets.chomp.to_i
  print "Gender: "
  gender = gets.chomp
  print "Species: "
  species = gets.chomp

  # Add animal to shelter
  animal = Animal.new(name, age, gender, species)
  shelter.add_animal(animal)

  puts "#{name} added to shelter"
end

# Prompt user for client details and
# add new client to shelter
def add_client(shelter)
  # Get details for new client
  print "Client name: "
  name = gets.chomp
  print "No. of children: "
  children = gets.chomp.to_i
  print "Age: "
  age = gets.chomp.to_i

  # Add client to shelter
  client = Client.new(name, children, age)
  shelter.add_client(client)

  puts "#{name} added to client list"
end

# Assign selected pet to selected client
def assign_client_pet(shelter)
  # Get client details
  print "Client name: "
  client_name = gets.chomp
  client = shelter.find_client(client_name)
  # Show error if client not found
  if client == nil
    puts "Client not found"
    return
  end

  # Get animal details
  print "Animal name: "
  animal_name = gets.chomp
  animal = shelter.find_animal(animal_name)
  # Show error if animal not found
  if animal == nil
    puts "Animal not found"
  else
    # Check if pet already adopted
    # If adopted, show error
    isAdopted = shelter.get_clients.select { |client|
      client.get_pets.index(animal) != nil
    }.length > 0
    if isAdopted
      puts "Pet has already been adopted"
    # Else, assign pet to client
    else
      client.adopt_pet(animal)
      puts "#{client.get_name} has adopted #{animal.get_name}"
    end
  end
end

# Remove selected pet from client
def remove_client_pet(shelter)
  # Get client details
  print "Client name: "
  client_name = gets.chomp
  client = shelter.find_client(client_name)
  # Show error if client not found
  if client == nil
    puts "Client not found"
    return
  end

  # Get animal details
  print "Animal name: "
  animal_name = gets.chomp
  animal = shelter.find_animal(animal_name)
  # Show error if animal not found
  if animal == nil
    puts "Animal not found"
  # Show error if client does not own pet
  elsif client.get_pets.index(animal) == nil
    puts "#{client.get_name} does not own #{animal.get_name}"
  # Else, remove pet from client's pets
  else
    client.remove_pet(animal)
    puts "#{client.get_name} has put #{animal.get_name} up for adoption"
  end
end

puts "Happitails Animal Shelter"
puts SEPARATOR

# Main loop
loop do
  # Print menu
  puts "Options"
  puts "1) Display all animals"
  puts "2) Display all clients"
  puts "3) Add animal"
  puts "4) Add client"
  puts "5) Assign client pet"
  puts "6) Remove client pet"
  puts "X) Exit"
  print "Enter an option: "
  option = gets.chomp
  puts ""

  # Perform selected option
  case option
    when "1"
      puts "Display all animals"
      puts SEPARATOR
      display_animals(shelter)
    when "2"
      puts "Display all clients"
      puts SEPARATOR
      display_clients(shelter)
    when "3"
      puts "Add animal"
      puts SEPARATOR
      add_animal(shelter)
    when "4"
      puts "Add client"
      puts SEPARATOR
      add_client(shelter)
    when "5"
      puts "Assign client pet"
      puts SEPARATOR
      assign_client_pet(shelter)
    when "6"
      puts "Remove client pet"
      puts SEPARATOR
      remove_client_pet(shelter)
    when "X"
      break
    else
      puts "Invalid option. Please try again"
  end

  puts ""
end

puts "Bye."

# binding.pry
