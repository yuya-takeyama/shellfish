require 'shellfish/problem_loader'
require 'rspec/expectations/differ'
require 'readline'

module Shellfish
  class Application
    def initialize(argv)
      @argv   = argv
      @argv   = [File.expand_path('../../examples/fizzbuzz.rb', File.dirname(__FILE__))] if @argv.empty?
      @loader = ProblemLoader.new
      @differ = RSpec::Expectations::Differ.new
    end

    def start
      @argv.each do |file|
        try_problem @loader.load(file)
      end
      puts "Good bye."
    end

    def try_problem(problem)
      show_problem(problem)
      while buf = ::Readline.readline('shellfish $ ', true)
        break if buf =~ /^\s*:?exit\s*$/
        if buf =~ /^\s*:show\s*$/
          show_problem
          next
        end
        got = `#{buf}`
        if problem.expected_result != got
          puts "NG"
          show_string @differ.diff_as_string(got, problem.expected_result)
        else
          puts "OK"
          show_string got
          puts "Congratulations!"
          break
        end
        puts
      end
    end

    def show_problem(problem)
      puts "Problem: #{problem.subject}" if problem.subject?
      puts "Description: #{problem.description}" if problem.desc?
      puts "Expected Result:"
      show_string problem.expected_result
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
