# == Schema Information
#
# Table name: wikis
#
#  id         :integer          not null, primary key
#  title      :string           default(""), not null
#  body       :text             default("")
#  private    :boolean          default(FALSE), not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_wikis_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :wiki do
    title "MyString"
    body "MyText"
    private false
    user nil
  end
end
