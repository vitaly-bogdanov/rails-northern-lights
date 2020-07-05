require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'валидно, если все поля переданны' do
    assert User.new(email: 'example@test.com', password: '123456').valid?
  end
  test 'невалидно, если поле password не переданно' do
    assert_not User.new(email: 'example@test.com').valid?
  end
  test 'невалидно, если поле email не переданно' do
    assert_not User.new(password: '123456').valid?
  end
  test 'невалидно, если вводимы email уже существует в базе' do
    user = { email: 'example@test.com', password: '123456' }
    User.create(user)
    assert_not User.new(user).valid?
  end
  test 'невалидно, если вводимые в поле email данные не являются адрессом электронной почты' do
    assert_not User.new(email: 'example_error', password: '123456').valid?
  end
  test 'невалидно, если пароль не соответствует длинне (меньше 6 симолов)' do
    assert_not User.new(email: 'example@test.com', password: '12345').valid? 
  end
end
