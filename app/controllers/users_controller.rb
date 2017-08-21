class UsersController < ApplicationController
  def downgrade
    current_user.update(role:'standard')
    current_user.wikis.update_all(private: false)
    redirect_to edit_user_registration_path
  end
end
