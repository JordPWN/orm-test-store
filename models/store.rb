class Store < ActiveRecord::Base
	validates :name, presence: true, length: {maximum: 25}
	validates :annual_revenue,  numericality: {:greater_than_or_equal_to => 0}
	validates :male_employees, numericality: {:greater_than_or_equal_to => 0}
	validates :female_employees, numericality: {:greater_than_or_equal_to => 0}
	has_many :employees

	def annual_expense
		employees.map(&:annual_salary).reduce(:+)
	end

	def annual_profit
		annual_revenue - annual_expense
	end

end
