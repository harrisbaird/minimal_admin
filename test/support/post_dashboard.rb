class PostDashboard < MinimalAdmin::BaseDashboard
  MODEL = Post

  INDEX_FIELDS = {
    id: Field::PrimaryKey.new,
    user: Field::BelongsTo.new,
    name: Field::String.new,
    count: Field::Integer.new,
    color: Field::Color.new,
    active: Field::Boolean.new
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
