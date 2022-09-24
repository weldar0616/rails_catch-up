class CommentsController < ApplicationController
  http_basic_authenticate_with name: 'dhh', password: 'secret', only: :destroy

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @artice = Article.find(params[:article_id])
    @comment = @artice.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@artice), status: 303
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end
end
