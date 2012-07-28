require 'shellfish/problem_loader'
require 'rspec/expectations/differ'
require 'readline'

module Shellfish
  class Application
    def initialize(argv)
      @argv   = argv
      @loader = ProblemLoader.new
      @differ = RSpec::Expectations::Differ.new
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
        if @problem.expected_result != got
          puts "NG"
          show_string @differ.diff_as_string(got, @problem.expected_result)
        else
          puts "OK"
          show_string got
          puts "Congratulations!"
          break
        end
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

    def show_string(string)
      puts "-" * 72
      print string
      puts
      puts "-" * 72
    end
  end
end
