# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

Rails.application.config.assets.precompile += %w( materialize.css materialize.js )
Rails.application.config.assets.precompile += %w( client.css client.js )

Rails.application.config.assets.precompile += %w( admin/search_products.css )
Rails.application.config.assets.precompile += %w( admin/layout.css )
Rails.application.config.assets.precompile += %w( admin/products.css )
Rails.application.config.assets.precompile += %w( admin/calls.css )
Rails.application.config.assets.precompile += %w( admin/categories.css )
Rails.application.config.assets.precompile += %w( admin/portfolios.css )
Rails.application.config.assets.precompile += %w( admin/contacts.css )
Rails.application.config.assets.precompile += %w( admin/order_calls.css )
Rails.application.config.assets.precompile += %w( admin/orders.css )
Rails.application.config.assets.precompile += %w( admin.js )
Rails.application.config.assets.precompile += %w( authentication.css authentication.js )
Rails.application.config.assets.precompile += %w( particles.js )