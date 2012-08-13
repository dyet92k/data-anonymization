class CustomerSample

  class CreateCustomer < ActiveRecord::Migration
    def up
      create_table :customers, { :id => false } do |t|
        t.integer :cust_id, :primary => true
        t.string :first_name
        t.string :last_name
        t.date :birth_date
        t.string :address
        t.string :state
        t.string :zipcode
        t.string :phone
        t.string :email
      end
    end
  end

  def self.clean
    system "rm -f tmp/*.sqlite"
    system "mkdir -p tmp"
  end

  def self.create_schema connection_spec
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Base.establish_connection connection_spec
    CreateCustomer.migrate :up
  end

  SAMPLE_DATA = {:cust_id => 100, :first_name => "Sunit", :last_name => "Parekh",
                 :birth_date => Date.new(1977,7,8), :address => "F 501 Shanti Nagar",
                 :state => "Maharastra", :zipcode => "411048", :phone => "9923700662",
                 :email => "parekh.sunit@gmail.com"}

  def self.insert_record connection_spec, data_hash = SAMPLE_DATA
    DataAnon::Utils::TempDatabase.establish_connection connection_spec
    source = DataAnon::Utils::BaseTable.create_table 'customers', 'cust_id',DataAnon::Utils::TempDatabase
    cust = source.new data_hash
    cust.cust_id = data_hash[:cust_id]
    cust.save!
  end

end