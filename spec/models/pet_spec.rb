require "rails_helper"

RSpec.describe Pet do
  describe "validations" do
    it { should validate_presence_of :image }
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :shelter }
  end

  describe "relationships" do
    it { should belong_to :shelter }
    it {should have_many :application_pets}
    it {should have_many(:apps).through(:application_pets)}
  end
end
