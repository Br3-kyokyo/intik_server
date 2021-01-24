FactoryBot.define do
    factory :admin, class: User do
      name {'admin'}
      admin {true}
      email {'admin@example.com'}
      password {'password'}
    end

    factory :member, class: User do
      name {'member'}
      admin {false}
      email {'member@example.com'}
      password {'password'}
    end
end