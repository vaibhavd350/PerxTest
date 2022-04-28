require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model  do
  let!(:user)  { create(:user) }

  it "is valid with valid attributes" do 
    expect(user).to be_valid
  end

end
