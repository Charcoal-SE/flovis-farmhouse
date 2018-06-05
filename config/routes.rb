# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'posts#index'

  get 'posts',     to: 'posts#index', as: :posts
  get 'posts/:id', to: 'posts#show',  as: :post
end
