require "application_system_test_case"

class RoomServicesTest < ApplicationSystemTestCase
  setup do
    @room_service = room_services(:one)
  end

  test "visiting the index" do
    visit room_services_url
    assert_selector "h1", text: "Room services"
  end

  test "should create room service" do
    visit room_services_url
    click_on "New room service"

    fill_in "Room", with: @room_service.room_id
    fill_in "Service", with: @room_service.service_id
    click_on "Create Room service"

    assert_text "Room service was successfully created"
    click_on "Back"
  end

  test "should update Room service" do
    visit room_service_url(@room_service)
    click_on "Edit this room service", match: :first

    fill_in "Room", with: @room_service.room_id
    fill_in "Service", with: @room_service.service_id
    click_on "Update Room service"

    assert_text "Room service was successfully updated"
    click_on "Back"
  end

  test "should destroy Room service" do
    visit room_service_url(@room_service)
    click_on "Destroy this room service", match: :first

    assert_text "Room service was successfully destroyed"
  end
end
