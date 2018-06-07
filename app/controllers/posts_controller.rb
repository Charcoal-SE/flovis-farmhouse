# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.includes(:site, :stages).order(created_at: :desc).paginate(page: params[:page], per_page: 100)
  end

  def search
    return unless params[:q].present?
    match = %r{https?://([^/]+)/[^/]+/(\d+)}.match(params[:q])
    @posts = if match
               Post.includes(:site, :stages).joins(:site).where(sites: { domain: match[1] }, posts: { native_id: match[2] })
             else
               []
             end
  end

  def show
    @post = Post.find(params[:id])
  end
end
