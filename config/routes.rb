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
  get "/letters/:id/response",  to: "letters#new_response",   as: "new_response_letter"
  get "/letters/new/out",       to: "letters#new_out",        as: "new_out_letter"
  get "/letters/:id/send",      to: "letters#sending",        as: "send_notice_letter"
  root 'letters#index'
end
