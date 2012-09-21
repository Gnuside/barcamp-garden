require 'test_helper'

class WorkshopAttendeesControllerTest < ActionController::TestCase
  setup do
    @workshop_attendee = workshop_attendees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workshop_attendees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workshop_attendee" do
    assert_difference('WorkshopAttendee.count') do
      post :create, workshop_attendee: { comment: @workshop_attendee.comment, user: @workshop_attendee.user, workshop: @workshop_attendee.workshop }
    end

    assert_redirected_to workshop_attendee_path(assigns(:workshop_attendee))
  end

  test "should show workshop_attendee" do
    get :show, id: @workshop_attendee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workshop_attendee
    assert_response :success
  end

  test "should update workshop_attendee" do
    put :update, id: @workshop_attendee, workshop_attendee: { comment: @workshop_attendee.comment, user: @workshop_attendee.user, workshop: @workshop_attendee.workshop }
    assert_redirected_to workshop_attendee_path(assigns(:workshop_attendee))
  end

  test "should destroy workshop_attendee" do
    assert_difference('WorkshopAttendee.count', -1) do
      delete :destroy, id: @workshop_attendee
    end

    assert_redirected_to workshop_attendees_path
  end
end
