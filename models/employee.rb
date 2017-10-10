class Employee < ActiveRecord::Base
	validates :first_name, presence: true 
	validates :last_name, presence: true
  
  belongs_to :store

  after_save :update_employee_counts
  after_destroy :update_employee_counts

  def annual_salary
  	hourly_rate * 1950
  end

  def self.average_hourly_rate_for(gender)
  	unless gender.nil?
  		Employee.where(gender: gender).average(:hourly_rate).round(2)
  	else
			Employee.average(:hourly_rate).round(2)
		end
	end
	
	private

  def update_employee_counts
    count = store.employees.where(gender: self.gender).count
    case gender
    when "F"
      store.female_employees = count
    when "M"
      store.male_employees = count
    end
    store.save
  end

end
