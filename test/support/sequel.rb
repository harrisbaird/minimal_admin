require 'sequel'

DB = Sequel.sqlite

Sequel::Model.plugin :schema
Sequel::Model.plugin :validation_helpers

class User < Sequel::Model
  one_to_many :posts

  create_table do
    primary_key :id
    String :name
  end
end

class Post < Sequel::Model
  many_to_one :user

  create_table do
    primary_key :id
    foreign_key :user_id, :users, null: false
    String :name
    Integer :count, default: 0
    String :color, default: '#000'
    Boolean :active, default: true
  end

  def validate
    validates_presence [:user, :name]
    super
  end
end

DB[:users].import([:id, :name], Array.new(1000) { |i| [i, "Test User #{i}"] })
user_ids = User.select_map(:id)
DB[:posts].import([:id, :name, :user_id], Array.new(1000) { |i| [i, "Test Post #{i}", user_ids.sample] })
