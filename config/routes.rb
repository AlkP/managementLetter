Rails.application.routes.draw do
  resources :cb_mails
  resources :type_letters
  resources :recipients
  resources :letters do
    resources :cb_mails
    resources :type_letters
    resources :letters
  end
  resources :attacheds do
    resources :letters do
      resources :letters do
        resources :cb_mails
      end
      resources :cb_mails
    end
  end
  get "/letters/:id/send" => "letters#sending"
  root 'letters#index'
end
