RailsAdmin.config do |config|
  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    config.authenticate_with do
      warden.authenticate! scope: :user
    end

    config.current_user_method(&:current_user)
  end
end
