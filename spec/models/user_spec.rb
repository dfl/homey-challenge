require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:sessions).dependent(:destroy) }
    it { should have_many(:comments) }
    it { should have_many(:projects).through(:comments) }
  end

  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }

    it 'validates password length when provided' do
      user = build(:user, password: 'Short')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('is too short (minimum is 12 characters)')
    end

    it 'does not require password on update' do
      user = create(:user)
      user.update(email: 'new-email@example.com')

      expect(user).to be_valid
    end
  end

  describe 'email normalization' do
    it 'downcases and strips the email before saving' do
      user = create(:user, email: ' Test@Example.COM ')
      expect(user.email).to eq('test@example.com')
    end
  end

  describe 'callbacks' do
    let(:user) { create(:user, email: 'old@example.com', verified: true) }

    context 'when email is changed' do
      it 'sets verified to false' do
        user.update(email: 'new@example.com')
        expect(user.verified).to be_falsey
      end
    end

    context 'when password is changed' do
      let!(:session1) { create(:session, user: user) }
      let!(:session2) { create(:session, user: user) }

      before { Current.session = session1 }

      it 'destroys all sessions except the current one' do
        user.update(password: 'newsecurepassword123')
        expect(user.sessions).to contain_exactly(session1)
      end
    end
  end

  describe 'token generation' do
    let(:user) { create(:user) }

    it 'generates an email verification token' do
      token = user.generate_token_for(:email_verification)
      expect(token).to be_present
    end

    it 'generates a password reset token' do
      token = user.generate_token_for(:password_reset)
      expect(token).to be_present
    end
  end

  describe '#initials' do
    it 'returns initials for full name' do
      user = build(:user, full_name: 'John Doe')
      expect(user.initials).to eq('JD')
    end

    it 'handles multiple word names' do
      user = build(:user, full_name: 'John Middle Doe')
      expect(user.initials).to eq('JMD')
    end
  end
end
