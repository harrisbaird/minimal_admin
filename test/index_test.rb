require 'test_helper'

class HomeTest < Minitest::Capybara::Test
  def test_index_redirection
    visit '/'
    assert_equal '/posts/index', current_path
  end
end
