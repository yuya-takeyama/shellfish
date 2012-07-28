require 'shellfish/problem_loader'
require 'readline'

module Shellfish
  class Application
    def initialize(argv)
      @argv   = argv
      @loader = ProblemLoader.new
    end

    def start
      @problem = @loader.load(@argv[0])
      while buf = ::Readline.readline('shellfish $ ', true)
        break if buf =~ /^\s*:?exit\s*$/
        if buf =~ /^\s*:show\s*$/
          show_problem
          next
        end
        got = `#{buf}`
        print got
        puts
      end
      puts "Good bye."
    end

    def show_problem
      puts "Problem: #{@problem.subject}" if @problem.subject?
      puts "Description: #{@problem.description}" if @problem.desc?
      puts "Expected Result:\n#{@problem.expected_result}"
      puts
    end
  end
end
