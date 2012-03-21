Doctor::Application.routes.draw do



  resources :states

  resources :countries

  # welcome screen
  root :to => "home#index"


   devise_for :users
  
   resources  :sub_categories_ds
   resources  :categories_ds
   resources  :users
   resources  :docters
   resources  :hospitals
   resources  :patients
   resources  :enquiries
   namespace  :user do |user|
       resources  :hospitals
    match '/dashboard'  => "home#new", :as => :root
   end


end
