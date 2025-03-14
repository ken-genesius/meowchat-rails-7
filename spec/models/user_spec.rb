require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:messages) }
    it { is_expected.to have_many(:chatroommembers) }
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
