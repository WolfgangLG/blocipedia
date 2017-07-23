require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { {
      title: "Example Wiki Title",
      body: "Example Wiki Body",
      private: false,
      user_id: user.id
  } }

  describe "GET #index" do
    context "when user is logged out" do
      it "returns a 302 http status" do
        get :index
        expect(response).to have_http_status(302)
      end

      it "redirects the user" do
        wiki = Wiki.create! valid_attributes
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is logged in" do
      before(:each) do
        sign_in user
      end

      it "returns http success" do
        wiki = Wiki.create! valid_attributes
        get :index
        expect(response).to have_http_status(200)
      end

      it "renders the index view" do
        wiki = Wiki.create! valid_attributes
        get :index
        expect(response).to render_template :index
      end

      it "assigns all wikis as @wikis" do
        wiki = Wiki.create! valid_attributes
        get :index
        expect(assigns(:wikis)).to include(wiki)
      end
    end
  end

  describe "GET #show" do
    context "when user is logged out" do
      it "returns a 302 http status" do
        wiki = Wiki.create! valid_attributes
        get :show, id: wiki.id
        expect(response).to have_http_status(302)
      end

      it "redirects unauthorized users" do
        wiki = Wiki.create! valid_attributes
        get :show, id: wiki.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is logged in" do
      before(:each) do
        sign_in user
      end

      it "returns http success" do
        wiki = Wiki.create! valid_attributes
        get :show, id: wiki.id
        expect(response).to have_http_status(200)
      end

      it "renders the show view" do
        wiki = Wiki.create! valid_attributes
        get :show, id: wiki.id
        expect(response).to render_template :show
      end

      it "assigns wiki to @wiki" do
        wiki = Wiki.create! valid_attributes
        get :show, id: wiki.id
        expect(assigns(:wiki)).to eq(wiki)
      end
    end
  end

  describe "GET #new" do
    context "when user is logged out" do
      it "returns a 302 http status" do
        get :new
        expect(response).to have_http_status(302)
      end

      it "redirects unauthorized users" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is logged in" do
      before(:each) do
        sign_in user
      end

      it "returns http success" do
        get :new
        expect(response).to have_http_status(200)
      end

      it "renders the new views" do
        get :new
        expect(response).to render_template :new
      end
    end
  end

  describe "POST #create" do
    context "when user is logged out" do
      it "returns a 302 http status" do
        post :create, wiki: valid_attributes
        expect(response).to have_http_status(302)
      end

      it "redirects unauthorized users" do
        post :create, wiki: valid_attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is logged in" do
      before(:each) do
        sign_in user
      end

      it "creates a new wiki" do
        expect {
          post :create, wiki: valid_attributes
        }.to change(Wiki, :count).by(+1)
      end

      it "assigns a newly created wiki as @wiki" do
        post :create, wiki: valid_attributes
        expect(assigns(:wiki)).to be_a(Wiki)
        expect(assigns(:wiki)).to be_persisted
      end

      it "redirects to the wiki" do
        post :create, wiki: valid_attributes
        expect(response).to redirect_to(Wiki.last)
      end
    end
  end

  describe "GET #edit" do
    context "when user is logged out" do
      it "returns a 302 http status" do
        wiki = Wiki.create! valid_attributes
        get :edit, id: wiki.id
        expect(response).to have_http_status(302)
      end

      it "redirects unauthorized users" do
        wiki = Wiki.create! valid_attributes
        get :edit, id: wiki.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is logged in" do
      before(:each) do
        sign_in user
      end

      it "returns http success" do
        wiki = Wiki.create! valid_attributes
        get :edit, id: wiki.id
        expect(response).to have_http_status(200)
      end

      it "renders the edit view" do
        wiki = Wiki.create! valid_attributes
        get :edit, id: wiki.id
        expect(response).to render_template :edit
      end

      it "assigns the requested wiki as @wiki" do
        wiki = Wiki.create! valid_attributes
        get :edit, id: wiki.id
        expect(assigns(:wiki)).to eq(wiki)
      end

      it "assigns wiki to be updated to @wiki" do
        wiki = Wiki.create! valid_attributes
        get :edit, id: wiki.id
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq wiki.id
        expect(wiki_instance.title).to eq wiki.title
        expect(wiki_instance.user_id).to eq wiki.user_id
      end
    end
  end

  describe "PUT #update" do
    context "when user is logged out" do
      it "returns a 302 http status" do
        wiki = Wiki.create! valid_attributes
        put :update, id: wiki.id, wiki: { title: "New Example Wiki Title", private: true }
        expect(response).to have_http_status(302)
      end

      it "redirects unauthorized users" do
        wiki = Wiki.create! valid_attributes
        put :update, id: wiki.id, wiki: { title: "New Example Wiki Title", private: true }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is logged in" do
      before(:each) do
        sign_in user
      end

      it "assigns the wiki as @wiki" do
        wiki = Wiki.create! valid_attributes
        put :update, id: wiki.id, wiki: { title: "New Example Wiki Title", private: true }
        expect(assigns(:wiki)).to eq(wiki)
      end

      it "updates the requested wiki" do
        wiki = Wiki.create! valid_attributes
        put :update, id: wiki.id, wiki: { title: "New Example Wiki Title", private: true }
        wiki.reload

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq wiki.id
        expect(updated_wiki.title).to eq wiki.title
        expect(updated_wiki.private).to eq wiki.private
        expect(updated_wiki.user_id).to eq wiki.user_id
      end

      it "redirects to the wiki" do
        wiki = Wiki.create! valid_attributes
        put :update, id: wiki.id, wiki: { title: "New Example Wiki Title", private: true }
        expect(response).to redirect_to(wiki)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when user is logged out" do
      it "returns a 302 http status" do
        wiki = Wiki.create! valid_attributes
        delete :destroy, id: wiki.id
        expect(response).to have_http_status(302)
      end

      it "redirects the user" do
        wiki = Wiki.create! valid_attributes
        delete :destroy, id: wiki.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is logged in" do
      before(:each) do
        sign_in user
      end

      it "destroys the requested wiki" do
        wiki = Wiki.create! valid_attributes
        delete :destroy, id: wiki.id
        count = Wiki.where({id: wiki.id}).size
        expect(count).to eq(0)
      end

      it "redirects to the wiki list" do
        wiki = Wiki.create! valid_attributes
        delete :destroy, id: wiki.id
        expect(response).to redirect_to(wikis_url)
      end
    end
  end
end
