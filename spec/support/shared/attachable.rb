shared_examples_for 'Attachable' do
  it { should have_many(:attachments).dependent(:destroy) }
end