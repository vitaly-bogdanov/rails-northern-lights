require 'openssl'
require 'google/cloud/storage'

# require 'aws-sdk-s3'

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://www.severnoe-siyanie.ru'
# SitemapGenerator::Sitemap.public_path = 'tmp/sitemap'
# hosts for sitemap
#aws_s3_host = "https://#{ENV['S3_BUCKET_NAME']}.s3.#{ENV['AWS_REGION']}.amazonaws.com/"
google_clud_storage_host = "https://console.cloud.google.com/storage/browser/#{ENV['GCS_BUCKET']}/"

SitemapGenerator::Sitemap.sitemaps_host = google_clud_storage_host
# SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

# для AWS S3
# SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
#   ENV['S3_BUCKET_NAME'],
#   aws_region: ENV['AWS_REGION'],
#   aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
#   aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
# )

# для Google Cloud Storage
SitemapGenerator::Sitemap.adapter = SitemapGenerator::GoogleStorageAdapter.new(
  project_id: ENV['GCS_PROJECT_ID'],
  bucket: ENV['GCS_BUCKET'],
  credentials: {
    "type": "service_account",
    "project_id": ENV['GCS_PROJECT_ID'],
    "private_key_id": ENV['GCS_PRIVATE_KEY_ID'],
    "private_key": ENV['GCS_PRIVATE_KEY'],
    "client_email": ENV['GCS_CLIENT_EMAIL'],
    "client_id": ENV['GCS_CLIENT_ID'],
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": ENV['GCS_CLIENT_X509_CERT_URL']
  }
)

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.

  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add root_path, priority: 0.7, changefreq: 'weekly'

  Category.find_each do |category|
    add shop_category_products_path(category), lastmod: category.updated_at
  end

  Product.find_each do |product|
    add shop_product_path(product), lastmod: product.updated_at
  end
end
