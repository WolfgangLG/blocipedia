module WikisHelper
  def private_wiki_permitted?
    current_user && (current_user.admin? || current_user.premium?)
  end
end
