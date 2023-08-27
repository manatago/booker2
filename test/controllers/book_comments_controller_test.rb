require "test_helper"

class BookCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get user:references" do
    get book_comments_user:references_url
    assert_response :success
  end

  test "should get comment:text" do
    get book_comments_comment:text_url
    assert_response :success
  end
end
