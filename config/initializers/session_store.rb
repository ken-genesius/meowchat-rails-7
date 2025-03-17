Rails.application.config.session_store :cookie_store, key: ENV.fetch(SESSION_KEY, "_fallback_session"),
  domain: :all, # Allow subdomains
  secure: Rails.env.production?, # Secure cookies in production
  httponly: true,
  same_site: :none
