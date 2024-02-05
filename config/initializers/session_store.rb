if Rails.env === 'production'
    Rails.application.config.session_store :cookie_store, key: '_goal_tracker_api_session', domain: :any
end