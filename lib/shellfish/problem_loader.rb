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
      dsl, data = input.split("__END__\n")
      script = <<-EOS
        Shellfish::ProblemDsl.new(Shellfish::Problem.new) {
          #{dsl}
        }.problem
      EOS
      problem = eval script, TOPLEVEL_BINDING
      problem.expected_result = data if data
      problem
    end
  end
end
