Rails.application.routes.draw do
  namespace :blog do
    resources :comments
    resources :posts
  end

  #
  # NOTE: Comments given here are in english to match auto-generated comments.
  #

  # A route connects an incoming URL with a controller action.
  #
  # For example, if we want to map an incoming request that
  # * is using the GET HTTP method and
  # * has the path '/pages'
  # such that it is processed by the index action in the PagesController,
  # we could write it like this.
  # get '/pages', to: 'pages#index'

  # There is a short-hand that reads:
  get '/pages' => 'pages#index'

  # NOTE: we are using two factors, HTTP method (GET) and request path (/pages).
  # Valid HTTP methods include GET, POST, PUT, PATCH and DELETE.

  # It is supported (even suggested) to reuse the same path with different methods.
  # Here is an example using the POST method with a request path that is
  # already in use (/pages).
  post '/pages' => 'pages#create'

  # Within our controllers and templates we often generate URLs. Instead
  # of hard-coding the URLs, it is advisable to reuse the information that
  # is already contained in our routes configuration. This is done by
  # using named routes.

  # By default, the name of the route is retrieved from the path given.
  # get '/pages' => 'pages#index' ==> Available as pages_path and pages_url

  # NOTE: pages_path is /pages, while pages_url is the full URL including the host
  # Use full URLs for redirects (as recommended in the HTTP specifications).

  # For instance, when using URLs in templates, instead of hard-coding the path
  # (which makes our templates hard to maintain).
  # <%= link_to 'Back', '/pages' %>

  # We can write
  # <%= link_to 'Back', pages_path %>

  # Resulting in the HTML
  # <a href="/pages">Pages</a>

  # We can customize the name
  get 'pages/new' => 'pages#new', as: :new_page

  # The path pattern may contain placeholders
  get 'pages/:id' => 'pages#show', as: :page

  # Now, id is available as params[:id] in pages#show

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
