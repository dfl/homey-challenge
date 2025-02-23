# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:users).through(:events) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(pending: 0, active: 1, complete: 2, archived: 3) }
  end

  describe 'callbacks' do
    context 'before_create' do
      it 'sets default status to pending if not provided' do
        project = Project.new(name: 'Test Project')
        project.save
        expect(project.status).to eq('pending')
      end
    end
  end

  describe '#events' do
    let(:project) { create(:project) }
    let(:comment) { create(:comment, project: project) }
    let(:status_change) { create(:status_change, project: project) }

    it 'returns comments and status changes in chronological order' do
      comment.update!(created_at: 2.days.ago)
      status_change.update!(created_at: 1.day.ago)

      expect(project.events.map(&:eventable)).to eq([ comment, status_change ])
    end
  end

  describe 'status tracking' do
    let(:project) { create(:project) }
    let(:user) { create(:user) }

    before do
      allow(Current).to receive(:user).and_return(user)
    end

    it 'tracks status changes' do
      project.status = :active

      expect {
        project.save!
      }.to change(Project::StatusChange, :count).by(1)

      change = Project::StatusChange.last
      expect(change.from_status).to eq('pending')
      expect(change.to_status).to eq('active')
      expect(change.user).to eq(user)
    end

    it 'does not track if status remains the same' do
      project.status = project.status

      expect {
        project.update!(name: 'New Name')
      }.not_to change(Project::StatusChange, :count)
    end
  end
end
