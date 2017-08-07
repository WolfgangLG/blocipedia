require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #new" do
    context "when user is not authenticated" do
      it "redirects the user" do
        get :new
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is standard" do
      before(:each) do
        sign_in user
      end

      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end

end
