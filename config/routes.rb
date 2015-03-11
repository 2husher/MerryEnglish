Rails.application.routes.draw do
  root "categories#index"

  # get 'categories/all' => 'categories#all', as: :categories_all

  # get 'category/:id' => 'categories#show', as: :category do
  resources :categories do
    member do
      get 'lessons/all'
      get 'lessons/:number', to: 'lessons#show', as: :lesson
      get 'translate_me/all', to: 'translate_me_game#all', as: :translate_me_all
      get 'translate_me/:lesson_number', to: 'translate_me_game#translate', as: :translate_me
      get 'dictionary/all'
      get 'dictionary/:letter', to: 'dictionary#letter', as: :dictionary
      get 'part_of_speech/:part_of_speech', to: 'dictionary#part_of_speech', as: :part_of_speech
    end
  end

  get 'search', to: 'search#find_words'

  get 'search_autocomplete', to: 'search#autocomplete_entity_word'

  get 'next_lesson/:category_id/:lesson_number', to: 'change_lesson#next', as: :next_lesson
  get 'previous_lesson/:category_id/:lesson_number', to: 'change_lesson#previous', as: :previous_lesson

  get 'next_translate_me/:category_id/:lesson_number', to: 'change_translate_me#next', as: :next_translate_me
  get 'previous_translate_me/:category_id/:lesson_number', to: 'change_translate_me#previous', as: :previous_translate_me

  get 'dictionary/all_words', to: 'dictionary#all_words', as: :dictionary_all
  get 'dictionary/:letter', to: 'dictionary#all_letters', as: :dictionary

  get 'part_of_speech/:part_of_speech', to: 'dictionary#all_part_of_speech', as: :part_of_speech

  get 'word/:word', to: 'dictionary#word', as: :word

  #get 'lessons/all' => 'lessons#all', as: :lessons_all

  #get 'lessons/:number' => 'lessons#number', as: :lesson

  #get 'translate_me/all' => 'translate_me_game#all', as: :translate_me_all

  #get 'translate_me/:lesson_number' => 'translate_me_game#translate', as: :translate_me


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
