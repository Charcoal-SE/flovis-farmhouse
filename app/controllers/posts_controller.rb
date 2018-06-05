# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.includes(:site, :stages).order(created_at: :desc).paginate(page: params[:page], per_page: 100)
  end

  def show
    @post = Post.find(params[:id])
  end
end
