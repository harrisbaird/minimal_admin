class PostDashboard < MinimalAdmin::BaseDashboard
  MODEL = Post

  def index_fields
    @index_fields ||= [
      Field::PrimaryKey.new(self, :id),
      Field::BelongsTo.new(self, :user, label: 'Author'),
      Field::String.new(self, :name),
      Field::Integer.new(self, :count),
      Field::Color.new(self, :color),
      Field::Boolean.new(self, :active)
    ]
  end

  def show_fields
    @show_fields ||= index_fields + [
      Field::InlineAssociation.new(self, :user)
    ]
  end

  def actions
    @actions ||= [
      Action::Index.new(self, index_fields),
      Action::Show.new(self, show_fields),
      Action::Edit.new(self, index_fields),
      Action::New.new(self, index_fields),
      Action::Delete.new(self)
    ]
  end
end
