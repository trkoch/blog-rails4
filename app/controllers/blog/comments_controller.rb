class Blog::CommentsController < ApplicationController
  before_action :set_comment, only: [:show]

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      # Raises ActiveRecord::RecordNotFound if Post cannot be found
      post = Post.find(params[:post_id])
      @comment = post.comments.find(params[:id])
    end
end
