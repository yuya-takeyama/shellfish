require 'shellfish/problem_loader'
require 'rspec/expectations/differ'
require 'readline'

module Shellfish
  class QuitException < ::Exception; end
  class NextProblemException < ::Exception; end
  class SkipEvaluationException < ::Exception; end

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
    rescue QuitException
      puts "Quitting shellfish..."
    ensure
      puts "Good bye."
    end

    def try_problem(problem)
      show_problem(problem)
      while input = ::Readline.readline('shellfish $ ', true)
        begin
        on_quit if input =~ /^\s*(?::?exit|:quit)\s*$/
        on_show_problem(problem) if input =~ /^\s*:show\s*$/

        output = `#{input}`
        if problem.expected_result != output
          on_ng problem, input, output
        else
          on_ok problem, input, output
        end
        puts
        rescue NextProblemException
          break
        rescue SkipEvaluationException
        end
      end
    end

    def on_ok(problem, input, output)
      puts "OK"
      show_string output
      puts "Congratulations!"
      raise NextProblemException
    end

    def on_ng(problem, input, output)
      puts "NG"
      show_string @differ.diff_as_string(output, problem.expected_result)
    end

    def on_quit
      raise QuitException
    end

    def on_show_problem(problem)
      show_problem problem
      raise SkipEvaluationException
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
