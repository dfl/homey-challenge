require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:users).through(:comments) }
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
end
