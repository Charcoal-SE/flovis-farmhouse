# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.clean_old_data
    posts = Post.where('created_at <= ?', 2.weeks.ago)
    stages = Stage.where(post_id: posts)
    stages.delete_all
    posts.delete_all
  end
end
