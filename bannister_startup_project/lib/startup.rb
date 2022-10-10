require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        salaries.keys.include?(title)
    end

    def >(other_startup)
        self.funding > other_startup.funding
    end

    def hire(employee_name, title)
        unless valid_title?(title)
            raise ArgumentError.new "invalid title"
        end

        @employees << Employee.new(employee_name, title)
    end

    def size
        employees.length
    end

    def pay_employee(employee)
        employee_salary = salaries[employee.title]

        if @funding > employee_salary
            @funding -= employee_salary
            employee.pay(employee_salary)

        else
            raise InsufficientFunding.new "not enough funding to pay employee"
        end
    end

    def payday
        @employees.each{ |employee| pay_employee(employee)}
    end

    def average_salary
        @employees.inject(0) {|sum, employee| sum += salaries[employee.title]} / employees.length
    end

    def close
        @funding = 0
        @employees = []

    end

    def acquire(startup)
        @funding += startup.funding
        startup.salaries.each do |title, salary|
            if !@salaries.include?(title)
                @salaries[title] = salary
            end
        end
        @employees += startup.employees
        startup.close
    end

    class InsufficientFunding < StandardError
    end
end
