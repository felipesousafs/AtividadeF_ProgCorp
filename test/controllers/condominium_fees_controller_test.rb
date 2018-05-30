require 'test_helper'

class CondominiumFeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @condominium_fee = condominium_fees(:one)
  end

  test "should get index" do
    get condominium_fees_url
    assert_response :success
  end

  test "should get new" do
    get new_condominium_fee_url
    assert_response :success
  end

  test "should create condominium_fee" do
    assert_difference('CondominiumFee.count') do
      post condominium_fees_url, params: { condominium_fee: { apartment_id: @condominium_fee.apartment_id, due_date: @condominium_fee.due_date, paid: @condominium_fee.paid, value: @condominium_fee.value } }
    end

    assert_redirected_to condominium_fee_url(CondominiumFee.last)
  end

  test "should show condominium_fee" do
    get condominium_fee_url(@condominium_fee)
    assert_response :success
  end

  test "should get edit" do
    get edit_condominium_fee_url(@condominium_fee)
    assert_response :success
  end

  test "should update condominium_fee" do
    patch condominium_fee_url(@condominium_fee), params: { condominium_fee: { apartment_id: @condominium_fee.apartment_id, due_date: @condominium_fee.due_date, paid: @condominium_fee.paid, value: @condominium_fee.value } }
    assert_redirected_to condominium_fee_url(@condominium_fee)
  end

  test "should destroy condominium_fee" do
    assert_difference('CondominiumFee.count', -1) do
      delete condominium_fee_url(@condominium_fee)
    end

    assert_redirected_to condominium_fees_url
  end
end
