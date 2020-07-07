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
end
