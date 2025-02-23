# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  ip_address :string
#  user_agent :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_sessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
FactoryBot.define do
  factory :session do
    association :user
    user_agent { "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)" }
    ip_address { "192.168.1.1" }
  end
end
