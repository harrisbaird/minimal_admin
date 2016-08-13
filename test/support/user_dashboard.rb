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
