require "application_system_test_case"

class RoomBedsTest < ApplicationSystemTestCase
  setup do
    @room_bed = room_beds(:one)
  end

  test "visiting the index" do
    visit room_beds_url
    assert_selector "h1", text: "Room beds"
  end

  test "should create room bed" do
    visit room_beds_url
    click_on "New room bed"

    fill_in "Bed", with: @room_bed.bed_id
    fill_in "Room", with: @room_bed.room_id
    click_on "Create Room bed"

    assert_text "Room bed was successfully created"
    click_on "Back"
  end

  test "should update Room bed" do
    visit room_bed_url(@room_bed)
    click_on "Edit this room bed", match: :first

    fill_in "Bed", with: @room_bed.bed_id
    fill_in "Room", with: @room_bed.room_id
    click_on "Update Room bed"

    assert_text "Room bed was successfully updated"
    click_on "Back"
  end

  test "should destroy Room bed" do
    visit room_bed_url(@room_bed)
    click_on "Destroy this room bed", match: :first

    assert_text "Room bed was successfully destroyed"
  end
end
