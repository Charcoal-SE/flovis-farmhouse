# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all
    @distinct_stages = Rails.cache.fetch :distinct_stages, expires_in: 1.day do
      Stage.select(Arel.sql('DISTINCT name')).map { |s| [s.name, s.name] }
    end

    @posts = @posts.where(site_id: params[:sites]) if params[:sites].present?

    if params[:stage].present?
      @posts = @posts.where(id: Post.joins(:stages).where(stages: { name: params[:stage] }))
    elsif params[:ls].present?
      @posts = @posts.where(id: Post.joins('INNER JOIN stages AS s1 ON s1.post_id = posts.id')
                                    .joins('LEFT JOIN stages AS s2 ON s2.post_id = posts.id AND s1.id < s2.id')
                                    .where(s2: { id: nil }, s1: { name: params[:ls] }))
    end

    @posts = @posts.includes(:site, :stages).order(created_at: :desc).paginate(page: params[:page], per_page: 100)
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
