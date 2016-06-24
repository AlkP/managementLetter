Rails.application.routes.draw do
  resources :cb_mails
  resources :type_letters
  resources :letters do
    resources :cb_mails
    resources :type_letters
    resources :letters
  end
  resources :attacheds do
    resources :letters do
      resources :cb_mails
    end
  end

  root 'letters#index'
end
