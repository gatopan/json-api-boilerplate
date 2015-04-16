require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  setup do
    @person = people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
  end

  test "should create person" do
    assert_difference('Person.count') do
      post :create, person: { email: @person.email, name: @person.name, role: @person.role, token: @person.token }
    end

    assert_response 201
  end

  test "should show person" do
    get :show, id: @person
    assert_response :success
  end

  test "should update person" do
    put :update, id: @person, person: { email: @person.email, name: @person.name, role: @person.role, token: @person.token }
    assert_response 204
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete :destroy, id: @person
    end

    assert_response 204
  end
end
