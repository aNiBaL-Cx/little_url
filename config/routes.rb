Rails.application.routes.draw do
  resources :minified_links, only: [:create, :index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => "minified_links#new"
  get '/:id', to: 'minified_links#goto_link', as: 'goto_minified_link'
end
