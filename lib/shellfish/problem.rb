module Shellfish
  class Problem
    attr_accessor :subject, :description, :expected_result

    def subject?
      !(@subject.nil?)
    end

    def description?
      !(@description.nil?)
    end
    alias desc? description?
  end
end
