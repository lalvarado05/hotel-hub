require "test_helper"

class RoomBedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @room_bed = room_beds(:one)
  end

  test "should get index" do
    get room_beds_url
    assert_response :success
  end

  test "should get new" do
    get new_room_bed_url
    assert_response :success
  end

  test "should create room_bed" do
    assert_difference("RoomBed.count") do
      post room_beds_url, params: { room_bed: { bed_id: @room_bed.bed_id, room_id: @room_bed.room_id } }
    end

    assert_redirected_to room_bed_url(RoomBed.last)
  end

  test "should show room_bed" do
    get room_bed_url(@room_bed)
    assert_response :success
  end

  test "should get edit" do
    get edit_room_bed_url(@room_bed)
    assert_response :success
  end

  test "should update room_bed" do
    patch room_bed_url(@room_bed), params: { room_bed: { bed_id: @room_bed.bed_id, room_id: @room_bed.room_id } }
    assert_redirected_to room_bed_url(@room_bed)
  end

  test "should destroy room_bed" do
    assert_difference("RoomBed.count", -1) do
      delete room_bed_url(@room_bed)
    end

    assert_redirected_to room_beds_url
  end
end
