ConstructorPages::Engine.routes.draw do
  scope '/admin' do
    resources :pages, except: [:show]
    resources :templates, except: [:show] do
      resources :fields, except: [:show, :index]
    end  

    %w{page template field}.each do |c|
      %w{up down}.each do |d|
        get "#{c.pluralize}/move/#{d}/:id" => "#{c.pluralize}#move_#{d}", as: "#{c}_move_#{d}"
      end
    end
  end

  root :to => 'pages#show'

  get '*all(.:format)' => 'pages#show', format: /(html|json|xml)/
end
