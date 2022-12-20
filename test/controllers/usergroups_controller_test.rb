require "test_helper"

class UsergroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usergroup = usergroups(:one)
  end

  test "should get index" do
    get usergroups_url, as: :json
    assert_response :success
  end

  test "should create usergroup" do
    assert_difference("Usergroup.count") do
      post usergroups_url, params: { usergroup: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show usergroup" do
    get usergroup_url(@usergroup), as: :json
    assert_response :success
  end

  test "should update usergroup" do
    patch usergroup_url(@usergroup), params: { usergroup: {  } }, as: :json
    assert_response :success
  end

  test "should destroy usergroup" do
    assert_difference("Usergroup.count", -1) do
      delete usergroup_url(@usergroup), as: :json
    end

    assert_response :no_content
  end
end
