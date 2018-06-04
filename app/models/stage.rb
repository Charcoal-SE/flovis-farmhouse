# frozen_string_literal: true

class Stage < ApplicationRecord
  belongs_to :post

  serialize :data, JSON
end
