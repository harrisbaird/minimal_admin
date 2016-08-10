Bundler.require

require 'minimal_admin'
require 'minimal_admin/app'

require 'sequel'

DB = Sequel.sqlite(logger: Logger.new(STDOUT))

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

user = User.create(name: 'Test User')
100.times.each { |i| User.create(name: "Test User #{i}") }
100.times.each { |i| Post.create(name: 'abc', user: user) }

class PostDashboard < MinimalAdmin::BaseDashboard
  MODEL = Post

  INDEX_FIELDS = {
    id: Field::PrimaryKey.new,
    user: Field::BelongsTo.new,
    name: Field::String.new,
    count: Field::Integer.new,
    color: Field::Color.new,
    active: Field::Boolean.new,
  }.freeze

  SHOW_FIELDS = INDEX_FIELDS.merge(
    user: Field::InlineAssociation.new
  ).freeze

  def actions
    @actions ||= [
      Action::Index.new(self, INDEX_FIELDS),
      Action::Show.new(self, SHOW_FIELDS),
      Action::Edit.new(self, INDEX_FIELDS),
      Action::New.new(self, INDEX_FIELDS),
      Action::Delete.new(self)
    ]
  end
end

class UserDashboard < MinimalAdmin::BaseDashboard
  MODEL = User

  INDEX_FIELDS = {
    id: Field::PrimaryKey.new,
    name: Field::String.new
  }.freeze

  SHOW_FIELDS = {
    id: Field::PrimaryKey.new,
    name: Field::String.new,
    posts: Field::InlineAssociation.new
  }

  FORM_FIELDS = {
    name: Field::String.new
  }.freeze

  def actions
    @actions ||= [
      Action::Index.new(self, INDEX_FIELDS),
      Action::Show.new(self, SHOW_FIELDS),
      Action::Edit.new(self, FORM_FIELDS),
      Action::New.new(self, FORM_FIELDS),
      Action::Delete.new(self)
    ]
  end
end

MinimalAdmin::App.setup_routes

# MinimalAdmin::App.routes.each do |route|
#   puts route
# end

run MinimalAdmin::App
