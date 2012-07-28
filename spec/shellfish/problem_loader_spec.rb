require 'shellfish/problem_loader'

module Shellfish
  describe ProblemLoader do
    let(:loader) { Shellfish::ProblemLoader.new }

    describe '#load_from_string' do
      subject { loader.load_from_string(input) }
      let(:input) { '' }

      it { should be_a(Problem) }

      context 'has subject' do
        let(:input) { 'subject "Subject of the problem"' }
        its(:subject) { should == "Subject of the problem" }
      end

      context 'has description' do
        let(:input) { 'desc "Description of the problem"' }
        its(:description) { should == "Description of the problem" }
      end
    end
  end
end