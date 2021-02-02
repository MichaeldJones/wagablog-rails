class Post < ApplicationRecord
  has_many :comments, dependent: :destroy

  def self.search(search)

    if search
      results = Post.find_by(title: search)

      if results
        self.where(id: results)
      else
        @posts = Post.all.order("created_at DESC")
      end
    else
      @posts = Post.all.order("created_at DESC")
    end
  end
end
