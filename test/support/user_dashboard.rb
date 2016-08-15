class UserDashboard < MinimalAdmin::BaseDashboard
  MODEL = User

  def index_fields
    @index_fields ||= [
      Field::PrimaryKey.new(self, :id),
      Field::String.new(self, :id)
    ]
  end

  def show_fields
    @show_fields ||= [
      Field::PrimaryKey.new(self, :id),
      Field::String.new(self, :name),
      Field::InlineAssociation.new(self, :posts)
    ]
  end

  def form_fields
    @form_fields ||= [
      Field::String.new(self, :name)
    ]
  end

  def actions
    @actions ||= [
      Action::Index.new(self, index_fields),
      Action::Show.new(self, show_fields),
      Action::Edit.new(self, form_fields),
      Action::New.new(self, form_fields),
      Action::Delete.new(self)
    ]
  end
end
