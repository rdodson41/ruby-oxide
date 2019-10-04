require('oxide')

RSpec.describe(Oxide) do
  it 'has a version number' do
    expect(Oxide::VERSION).not_to(be_nil)
  end

  describe '.hello_world' do
    subject :hello_world do
      described_class.hello_world
    end

    it 'returns "hello world"' do
      expect(hello_world).to(eq('hello world'))
    end
  end
end
