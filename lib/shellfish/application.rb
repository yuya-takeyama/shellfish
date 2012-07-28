require 'shellfish/problem_loader'
require 'rspec/expectations/differ'
require 'termcolor'
require 'optparse'
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
      opt = OptionParser.new
      opt.version = VERSION

      opt.parse!(@argv)
      play
    end

    def play
      @problem_count = @argv.size
      @current_count = 1
      @argv.each do |file|
        try_problem @loader.load(file)
        @current_count += 1
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
        on_skip if input =~ /^\s*:(?:skip|next)\s*$/
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
      puts "<green>OK</green>".termcolor
      puts
      show_string output
      puts "<green>Congratulations!</green>".termcolor
      puts
      raise NextProblemException
    end

    def on_ng(problem, input, output)
      puts "<red>NG</red>".termcolor
      puts
      show_diff output, problem.expected_result
    end

    def on_skip
      puts "<yellow>Skipped</yellow>".termcolor
      raise NextProblemException
    end

    def on_quit
      raise QuitException
    end

    def on_show_problem(problem)
      show_problem problem
      raise SkipEvaluationException
    end

    def show_diff(output, expected)
      diff = @differ.diff_as_string(output, expected).gsub(/^\n+/, '')
      colored_diff = ''
      diff.each_line do |line|
        if line[0] == '@'
          colored_diff += "<green><bold>#{line}</bold></green>".termcolor
        elsif line[0] == '+'
          colored_diff += "<blue><bold>#{line}</bold></blue>".termcolor
        elsif line[0] == '-'
          colored_diff += "<red><bold>#{line}</bold></red>".termcolor
        else
          colored_diff += line
        end
      end
      show_string colored_diff
    end

    def show_problem(problem)
      puts ("<blue>Problem</blue> (#{@current_count}/#{@problem_count}): " +
            "<bold>#{problem.subject}</bold>").termcolor
      puts "Description: #{problem.description}" if problem.desc?
      puts
      puts "<bold>Expected Result:</bold>".termcolor
      show_string "<cyan>#{problem.expected_result}</cyan>".termcolor
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
