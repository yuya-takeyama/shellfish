module Shellfish
  class ProblemDsl
    attr_reader :problem

    def initialize(problem, &block)
      @problem = problem
      instance_eval(&block) if block_given?
    end

    def subject(text)
      @problem.subject = text
    end

    def description(text)
      @problem.description = text
    end
    alias desc description

    def expected(text)
      @problem.expected = text
    end
  end
end
