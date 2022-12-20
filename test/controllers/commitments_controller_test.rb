require "test_helper"

class CommitmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @commitment = commitments(:one)
  end

  test "should get index" do
    get commitments_url, as: :json
    assert_response :success
  end

  test "should create commitment" do
    assert_difference("Commitment.count") do
      post commitments_url, params: { commitment: { commitmentamount: @commitment.commitmentamount, commitmentdesc: @commitment.commitmentdesc, expirationdate: @commitment.expirationdate, occurancedate: @commitment.occurancedate } }, as: :json
    end

    assert_response :created
  end

  test "should show commitment" do
    get commitment_url(@commitment), as: :json
    assert_response :success
  end

  test "should update commitment" do
    patch commitment_url(@commitment), params: { commitment: { commitmentamount: @commitment.commitmentamount, commitmentdesc: @commitment.commitmentdesc, expirationdate: @commitment.expirationdate, occurancedate: @commitment.occurancedate } }, as: :json
    assert_response :success
  end

  test "should destroy commitment" do
    assert_difference("Commitment.count", -1) do
      delete commitment_url(@commitment), as: :json
    end

    assert_response :no_content
  end
end
