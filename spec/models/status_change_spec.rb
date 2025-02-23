require 'rails_helper'

RSpec.describe Project::StatusChange, type: :model do
  let(:status_change) { build(:status_change) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end

  describe "validations" do
    it { should validate_presence_of(:from_status) }
    it { should validate_presence_of(:to_status) }
  end

  describe "callbacks" do
    context "after_create" do
      it "creates an event" do
        expect {
          status_change.save
        }.to change(Project::Event, :count).by(1)

        event = Project::Event.last
        expect(event.project).to eq(status_change.project)
        expect(event.user).to eq(status_change.user)
      end
    end
  end
end
