# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_v1Stories_session',
  :secret      => 'f5f93bfc1d1f69bca7a5e11d675cd87f0449ab86281b3eaccf597dfc7fa6123b2e7626d3bfdc003ec85f7a305b1e32f7e98e8347393e1c9c7088268e6f13bf5f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
