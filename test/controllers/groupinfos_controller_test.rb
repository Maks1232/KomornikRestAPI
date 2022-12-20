require "test_helper"

class GroupinfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @groupinfo = groupinfos(:one)
  end

  test "should get index" do
    get groupinfos_url, as: :json
    assert_response :success
  end

  test "should create groupinfo" do
    assert_difference("Groupinfo.count") do
      post groupinfos_url, params: { groupinfo: { groupname: @groupinfo.groupname } }, as: :json
    end

    assert_response :created
  end

  test "should show groupinfo" do
    get groupinfo_url(@groupinfo), as: :json
    assert_response :success
  end

  test "should update groupinfo" do
    patch groupinfo_url(@groupinfo), params: { groupinfo: { groupname: @groupinfo.groupname } }, as: :json
    assert_response :success
  end

  test "should destroy groupinfo" do
    assert_difference("Groupinfo.count", -1) do
      delete groupinfo_url(@groupinfo), as: :json
    end

    assert_response :no_content
  end
end
