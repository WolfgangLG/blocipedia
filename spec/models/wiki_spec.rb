# == Schema Information
#
# Table name: wikis
#
#  id         :integer          not null, primary key
#  title      :string           default(""), not null
#  body       :text             default("")
#  private    :boolean          default(TRUE), not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_wikis_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Wiki, type: :model do

  it { is_expected.to belong_to(:user) }
  describe "attributes" do
    it "has title, body, and privacy attributes" do

    end


  end
end
