FactoryBot.define do
  factory :admin, class: User do
    name { '管理者' }
    username { 'admin' }
    biography { '私は管理者です。' }
    admin { true }
    email { 'admin@example.com' }
    password { 'password' }
  end

  factory :member, class: User do
    name { 'メンバー' }
    username { 'member' }
    biography { '私はメンバーです。' }
    admin { false }
    email { 'member@example.com' }
    password { 'password' }
  end

  # factory :post01, class: Post do
  #   body { 'This is member post 01' }
  #   association :user, factory: :member
  # end

  # factory :post02, class: Post do
  #   body { 'This is member post 02' }
  #   association :user, factory: :member
  # end

  # factory :post03, class: Post do
  #   body { 'This is admin post 03' }
  #   association :user, factory: :admin
  # end
end
