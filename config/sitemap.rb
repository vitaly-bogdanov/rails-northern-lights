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
# SitemapGenerator::Sitemap.adapter = SitemapGenerator::GoogleStorageAdapter.new(
#   project_id: ENV['GCS_PROJECT_ID'],
#   bucket: ENV['GCS_BUCKET'],
#   credentials: {
#     "type": "service_account",
#     "project_id": ENV['GCS_PROJECT_ID'],
#     "private_key_id": ENV['GCS_PRIVATE_KEY_ID'],
#     "private_key": ENV['GCS_PRIVATE_KEY'],
#     "client_email": ENV['GCS_CLIENT_EMAIL'],
#     "client_id": ENV['GCS_CLIENT_ID'],
#     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
#     "token_uri": "https://oauth2.googleapis.com/token",
#     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
#     "client_x509_cert_url": ENV['GCS_CLIENT_X509_CERT_URL']
#   }
# )

SitemapGenerator::Sitemap.adapter = SitemapGenerator::GoogleStorageAdapter.new(
  project_id: "modular-glider-279817",
  bucket: "severnoe_siyanie",
  credentials: {
    "type": "service_account",
    "project_id": "modular-glider-279817",
    "private_key_id": "103ec5af7c9b92935d204554aee911b1a844b422",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC9Zd7HuusQ1cw+\n71UjOno0WXYAAaPycECyRORjpsN7/tJs4KDpWBU9FsTCuYTmi54qp3AA1qwsioR/\n3AtChr5lWO0s1fWTQVSXrmwfzKevxwBf8yFSPGSiS434pVk6/nKILJXThLlp5i4o\nnNGgQoSmdPTxQLJbGx2k4jeKJqByZvg+pCfFmSHSZ/9inKZ08AW65rmhsVpWqCyM\nvTr+KLVNlCHlA24STt1aFo+rqm+3kYEcSoECbCeY7uJNjrqoAw9uP9lcnOd307qG\nsO87Q6KRAU2h+ijXRzLLYQPfiufIP/uEQ0U1qs+2O6azkVGWu4J5/g5a/aX98zYB\ntHPkBl1ZAgMBAAECggEAAjz+dYDNf1zvdXzxliF+STkXbmeWjuppsVGkG1Ngswnv\nZa7/59INKjQnLh/wJKNYwqtI5RGkZkBa0YIBtg8Ol/cFkoaSyOM4QzSh/Xw3LRoe\ndIPUjHq/O7XF3z7g/5P7OYXBXYcPg+Ne/0bfKVQv6iGutV0s3mvDHWw4+M59De0J\nW5FHhDTMiUYJV9ELQ1DosVLhfjBmJw09rqy88cyy4bBo5HryXoLRVyO5lHDKN6a7\nVcvgduP8oDskb4pZgZ3Pgtx+XIVvXTIZD6Cy5SmgK0GUGT0wcAmhw989AjXmaD2M\nam1AB3+bAq572WWKCbzqDdC40NvZ/+mfNoFLdTNgqwKBgQD3crqPp+ndtQVEMo0E\nNHEr++0kjq/rsLbt9h4FqFaLIu0d2qPKAuMNMKclTsiVJUzjoq2VVKJ9Wjr5ANwe\n7EiZWRZhPlTQ5ihP6sVdboGcxp003jLu1MAUqQ8TOs5outDipL63q4YT7pWIUYB8\nbLZOKvwkAKh/oe1HjO1IpkuUmwKBgQDD8Yxa+LnDWNurNI+GXi/ZgPmklhlIfNNr\nPRKw8XS6e4mSNRDbmq4ierm2qXG/+498aYMNeGweMOWaE2uxZQXyTqxz+0/kx7mL\nbDy1YNTA6bXJfxjPgJqvPO1U0BETFgrkqBkkrXddUSdZF7tpJw+vW3oFmGsDEfFl\nkoYQzL2jGwKBgC/fQ1adjrI03kL2YK/KkYaH47Yp4MEBXDKnZeGEUtHyPNuEvCFN\n861Ol1exaT7pi3mStHBqglEsDrKzxuI4pkb8pEbF71TG4k+rxOkxguPYzPs4bbQk\n9tBIcMEwpFRAqD7gzoDsLzFV/Bn2Ypwv0AlJaaRxeCfRJP2ttw5SFdc3AoGBAJH0\n8iopsKZ1IFytsGPU8SvByTPyoy693Pa67ZtkoSDwOQ/x+3a6CBCi/oe0PIlXqBBy\nwC5ej5sFrWJSKRxhNkbCl+9lOqQeqnXS0H4DfTeeX82SoTagg5kZd2h//NgMyVx+\nYwxRMuMOOpNA/Fddw29KYuCcIsqMqRaSSM9m07QVAoGBAIsbl0IHmyXnm2gqzPjI\nTg4txVJVpEsplYbu1W8bKmA90U8LTzbhpd7qKw4MSKbrFk0eNZf9sYqd8Muys3Iv\nzET8c+IsSoW5tPRE8zwXExgThdj6JDshg5zKH9TONgf0FwPz7lFznUMgQci2IOPk\nbrwjqzEF8MgcXna4kSap0/m0\n-----END PRIVATE KEY-----\n",
    "client_email": "severnoe-siyanie@modular-glider-279817.iam.gserviceaccount.com",
    "client_id": "11246277333345724084",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/severnoe-siyanie%40modular-glider-279817.iam.gserviceaccount.com"
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
