require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { build(:comment) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end

  describe "validations" do
    it { should validate_presence_of(:text) }
  end

  describe "timeline_item concern" do
    it "implements timeline_date" do
      expect(comment.timeline_date).to eq(comment.created_at)
    end
  end
end
