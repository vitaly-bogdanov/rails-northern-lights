FactoryBot.define do
  factory :call do
    trait :roxanne do
      id { 1 }
      name { 'Roxanne' }
      telephone { '89990849417' }
      timezone { 'New-York' }
      confirm { true }
      notes { '' }
    end
  end
  
  factory :category do
    trait :rockets do
      id { 1 }
      name { 'rockets' }
      description { 'simple rockets' }
      keywords { 'test, rockets, sky' }
    end
  end

  factory :order_call do
    trait :new_order_call do
      id { 1 }
      name { 'Viktor' }
      telephone { '89990849417' }
      timezone { 'Tokio' }
      notes { '' }
      product_name { 'Unique Product' }
      product_price { 2000 }
      confirm { true }
      association :product, factory: [ :product, :unique_product ]
    end
  end

  factory :portfolio do
    trait :new_portfolio do
      id { 1 }
      name { 'New Portfolio' }
      description { 'test test test test' }
    end
  end

  factory :product do
    trait :apple do
      id { 1 }
      name { 'Apple' }
      preview { 'test test test test test test test test test test' }
      description { 'test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test' }
      price { 200 }
      keywords { 'test test' }
      unique { false }
      association :category, factory: [ :category, :rockets ]
    end
    trait :unique_product do
      id { 2 }
      name { 'Unique Product' }
      preview { 'test test test test test test test test test test' }
      description { 'test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test' }
      price { 2000 }
      keywords { 'test test' }
      unique { true }
      association :category, factory: [ :category, :rockets ]
    end
  end

  factory :order do
    trait :new_order do
      id { 1 }
      initials { Faker::Name.name_with_middle }
      telephone { "8#{Faker::Number.number(digits: 10)}" }
      region { Faker::Address.state }
      city { Faker::Address.city }
      address { Faker::Address.street_address }
      postcode { 678960 }
      comment { '' }
      timezone { Faker::Address.time_zone }
      tottal_price { 0 }
      email { Faker::Internet.email }
      confirm { true }
    end
  end

  factory :order_product do
    trait :new_order_product do
      id { 1 }
      product_name { Faker::Space.planet }
      unit_price { 100 }
      products_price { 100 }
      count_products { 1 }
      association :order, factory: [:order, :new_order]
      association :product, factory: [:product, :apple]
    end
  end
end
