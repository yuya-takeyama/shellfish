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

      context 'has expected result' do
        let(:input) { 'expected "Expected result of the problem"' }
        its(:expected) { should == "Expected result of the problem" }
      end

      context 'has expected result as data field' do
        let(:input) {
          "__END__\n" +
          "foo\n" +
          "bar\n" +
          "baz\n"
        }

        its(:expected) { should == "foo\nbar\nbaz\n" }
      end
    end
  end
end
