
# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.severnoe-siyanie.ru"

SitemapGenerator::Sitemap.public_path = 'tmp/sitemap'

SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(
  fog_provider: 'AWS',
  fog_directory: 'severnoe-siyanie',
  fog_region: 'ap-northeast-2',
  aws_access_key_id: 'AKIAYGSNYTI4LFK3FJK4',
  aws_secret_access_key: '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'
)

SitemapGenerator::Sitemap.sitemaps_host = "http://severnoe-siyanie.s3.amazonaws.com/"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/' 
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
    add shop_category_products_path(category), :lastmod => category.updated_at
  end

  Product.find_each do |product|
    add shop_product_path(product), :lastmod => product.updated_at
  end

end