# frozen_string_literal: true

require('oxide')

RSpec.describe(Oxide) do
  it 'has a version number' do
    expect(Oxide::VERSION).not_to(be_nil)
  end
end
