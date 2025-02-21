require 'rails_helper'

RSpec.describe ProjectStatusChange, type: :model do
  let(:status_change) { build(:project_status_change) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end

  describe "validations" do
    it { should validate_presence_of(:from_status) }
    it { should validate_presence_of(:to_status) }
  end

  describe "timeline_item concern" do
    it "implements timeline_date" do
      expect(status_change.timeline_date).to eq(status_change.created_at)
    end
  end
end
