module UsersHelper

  def favorite(post)
    favorites.find_or_create_by(post: post)
  end

  def unfavorite(post)
    favorites.where(post: post).destroy_all

    post.reload
  end


  def favorited?(post)
    favorites.find_by(post_id: post.id).present?
  end
end
