require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { {
      title: "Example Wiki Title",
      body: "Example Wiki Body",
      private: false,
      user_id: user.id
  } }

  context "guest user" do
    describe "GET #index" do
      it "redirects unauthenticated users" do
        wiki = Wiki.create! valid_attributes
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "authenticated user" do

  # describe "GET #show" do
  #   it "returns a success response" do
  #     wiki = Wiki.create! valid_attributes
  #     get :show, {:id => wiki.to_param}, valid_session
  #     expect(response).to be_success
  #   end
  # end
  #
  # describe "GET #new" do
  #   it "returns a success response" do
  #     get :new, {}, valid_session
  #     expect(response).to be_success
  #   end
  # end
  #
  # describe "GET #edit" do
  #   it "returns a success response" do
  #     wiki = Wiki.create! valid_attributes
  #     get :edit, {:id => wiki.to_param}, valid_session
  #     expect(response).to be_success
  #   end
  # end
  #
  # describe "POST #create" do
  #   context "with valid params" do
  #     it "creates a new Wiki" do
  #       expect {
  #         post :create, {:wiki => valid_attributes}, valid_session
  #       }.to change(Wiki, :count).by(1)
  #     end
  #
  #     it "redirects to the created wiki" do
  #       post :create, {:wiki => valid_attributes}, valid_session
  #       expect(response).to redirect_to(Wiki.last)
  #     end
  #   end
  #
  #   context "with invalid params" do
  #     it "returns a success response (i.e. to display the 'new' template)" do
  #       post :create, {:wiki => invalid_attributes}, valid_session
  #       expect(response).to be_success
  #     end
  #   end
  # end
  #
  # describe "PUT #update" do
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }
  #
  #     it "updates the requested wiki" do
  #       wiki = Wiki.create! valid_attributes
  #       put :update, {:id => wiki.to_param, :wiki => new_attributes}, valid_session
  #       wiki.reload
  #       skip("Add assertions for updated state")
  #     end
  #
  #     it "redirects to the wiki" do
  #       wiki = Wiki.create! valid_attributes
  #       put :update, {:id => wiki.to_param, :wiki => valid_attributes}, valid_session
  #       expect(response).to redirect_to(wiki)
  #     end
  #   end
  #
  #   context "with invalid params" do
  #     it "returns a success response (i.e. to display the 'edit' template)" do
  #       wiki = Wiki.create! valid_attributes
  #       put :update, {:id => wiki.to_param, :wiki => invalid_attributes}, valid_session
  #       expect(response).to be_success
  #     end
  #   end
  # end
  #
  # describe "DELETE #destroy" do
  #   it "destroys the requested wiki" do
  #     wiki = Wiki.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => wiki.to_param}, valid_session
  #     }.to change(Wiki, :count).by(-1)
  #   end
  #
  #   it "redirects to the wikis list" do
  #     wiki = Wiki.create! valid_attributes
  #     delete :destroy, {:id => wiki.to_param}, valid_session
  #     expect(response).to redirect_to(wikis_url)
  #   end
  # end
  end
end
