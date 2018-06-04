# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :site
  has_many :stages
end
