require 'rails_helper'

RSpec.describe Project::Comment, type: :model do
  let(:comment) { build(:comment) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end

  describe "validations" do
    it { should validate_presence_of(:body) }
  end

  describe "callbacks" do
    it "creates a timeline item after creation" do
      expect { comment.save }.to change(Project::Event, :count).by(1)
    end
  end
end
