require 'shellfish/problem_loader'

module Shellfish
  class Application
    def initialize(argv)
      @argv   = argv
      @loader = ProblemLoader.new
    end

    def start
      problem = @loader.load(@argv[0])
    end
  end
end
