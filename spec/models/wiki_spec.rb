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
  let(:user) { create(:user) }
  let(:my_public_wiki) { create(:wiki, user_id: user.id) }
  let(:my_private_wiki) { create(:wiki, private: true, user_id: user.id)}

  it { is_expected.to belong_to(:user) }

  describe "attributes" do
    it "has title, body, and privacy attributes" do
      expect(my_public_wiki).to have_attributes(title: "MyString", body: "MyText", private: false, user_id: user.id)
    end
  end

  describe "scopes" do
    before(:each) do
      @public_wiki = my_public_wiki
      @private_wiki = my_private_wiki
    end

    describe ".public_wikis" do
      it "returns all non-private wikis" do
        expect(Wiki.public_wikis).to eq(Wiki.where(private: false))
      end
    end

    describe ".visible_to(user)" do
      it "returns all wikis if user is present" do
        expect(Wiki.visible_to(user)).to eq(user.wikis.public_wikis)
      end

      it "returns only public topics if user is nil" do
        expect(Wiki.visible_to(user)).to eq([@public_wiki])
      end
    end
  end
end
