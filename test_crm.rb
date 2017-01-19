require_relative 'test_contact'

class CRM

  def initialize(name)
    @name = name
    print_main_menu
  end

  def main_menu
    if true #repeat indefinitely
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    print 'Enter a number: '
  end

  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_contacts
    when 5 then display_all_contacts
    when 6 then search_by_attribute
    end
  end

  def add_new_contact
    print 'Enter First Name: '
    first_name = gets.chomp
    print 'Enter Last Name: '
    last_name = gets.chomp
    print 'Enter Email Address: '
    email = gets.chomp
    print 'Enter a Note: '
    note = gets.chomp
    Contact.create(first_name, last_name, email, note)
    print_main_menu
  end

  def modify_existing_contact
    print 'Enter contact id #: '
    contact_id = gets.chomp
    modified_contact = Contact.find(contact_id)
      if modified_contact
        puts "Which info would you like to change?"
        puts "1. First Name"
        puts "2. Last Name"
        puts "3. Email Address"
        puts "4. Note"
        input = gets.chomp
        ma = modified_attribute(input)
        puts "Please enter new info"
        change = gets.chomp
        modified_contact.update(ma, change)
        print_main_menu
      else
        puts "Contact doesn't exist"
        print_main_menu
      end
  end

  def modified_attribute(input)
    if input == "1"
      "first_name"
    elsif input == "2"
      "last_name"
    elsif input == "3"
      "email"
    elsif input == "4"
      "note"
    else
      puts "Command doesn't exist, returning to Main Menu"
      print_main_menu
    end
  end

  def delete_contact
    print 'Enter contact id # to delete selected contact: '
    id = gets.chomp
    deleted_contact = Contact.find(id)
    puts "Are you sure you want to delete #{self.first_name} #{self.last_name}?"
    print 'Type "y" to confirm or "n" to cancel'
    confirm = gets.chomp
      if confirm == "y"
        deleted_contact.delete
        puts "Contact deleted!"
        print_main_menu
      else
        puts "Action Cancelled"
        print_main_menu
      end
  end

  # This method should accept as an argument an array of contacts
  # and display each contact in that array
  def display_contacts

    # HINT: Make use of this method in the display_all_contacts and search_by_attribute methods to keep your code DRY
  end

  def display_all_contacts
    Contact.all.each do |contact|
    end
    print_main_menu
    # HINT: Make use of the display_contacts method to keep your code DRY
  end

  def search_by_attribute
    print 'Enter one of the following pieces of info to search by: '
    print 'first_name, last_name, email or note'
    attribute = gets.chomp
    print 'Enter filter for selected info: '
    filter = gets.chomp
    searched_contact = Contact.find_by(attribute, filter)
      if searched_contact
        print "#{self.first_name}, #{self.last_name}, #{self.email}, #{self.note}"
      else
        puts "Contact doesn't exist"
      end
      print_main_menu
    # HINT: Make use of the display_contacts method to keep your code DRY
  end
  # Add other methods here, if you need them.
end
