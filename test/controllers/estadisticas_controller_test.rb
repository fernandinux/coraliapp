require 'test_helper'

class EstadisticasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @estadistica = estadisticas(:one)
  end

  test "should get index" do
    get estadisticas_url, as: :json
    assert_response :success
  end

  test "should create estadistica" do
    assert_difference('Estadistica.count') do
      post estadisticas_url, params: { estadistica: { add_linkedin_count: @estadistica.add_linkedin_count, list_name: @estadistica.list_name, list_visits_count: @estadistica.list_visits_count, share_linkedin: @estadistica.share_linkedin, user_id: @estadistica.user_id, web_views_count: @estadistica.web_views_count } }, as: :json
    end

    assert_response 201
  end

  test "should show estadistica" do
    get estadistica_url(@estadistica), as: :json
    assert_response :success
  end

  test "should update estadistica" do
    patch estadistica_url(@estadistica), params: { estadistica: { add_linkedin_count: @estadistica.add_linkedin_count, list_name: @estadistica.list_name, list_visits_count: @estadistica.list_visits_count, share_linkedin: @estadistica.share_linkedin, user_id: @estadistica.user_id, web_views_count: @estadistica.web_views_count } }, as: :json
    assert_response 200
  end

  test "should destroy estadistica" do
    assert_difference('Estadistica.count', -1) do
      delete estadistica_url(@estadistica), as: :json
    end

    assert_response 204
  end
end
