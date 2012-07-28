require 'shellfish/problem'
require 'shellfish/problem_dsl'

module Shellfish
  class ProblemLoader
    def load(file)
      f = open(file)
      result = f.read
      f.close
      load_from_string(result)
    end

    def load_from_string(input)
      script = <<-EOS
        Shellfish::ProblemDsl.new(Shellfish::Problem.new) {
          #{input}
        }.problem
      EOS
      eval script, TOPLEVEL_BINDING
    end
  end
end
