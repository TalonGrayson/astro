require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tag = tags(:one)
  end

  test "should get index" do
    get tags_url
    assert_response :success
  end

  test "should get new" do
    get new_tag_url
    assert_response :success
  end

  test "should create tag" do
    assert_difference('Tag.count') do
      post tags_url, params: { tag: { attack: @tag.attack, defence: @tag.defence, deleted: @tag.deleted, health: @tag.health, last_seen: @tag.last_seen, light_rgb: @tag.light_rgb, name: @tag.name, origin: @tag.origin, speed: @tag.speed, tag_id: @tag.tag_id, type: @tag.type } }
    end

    assert_redirected_to tag_url(Tag.last)
  end

  test "should show tag" do
    get tag_url(@tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_tag_url(@tag)
    assert_response :success
  end

  test "should update tag" do
    patch tag_url(@tag), params: { tag: { attack: @tag.attack, defence: @tag.defence, deleted: @tag.deleted, health: @tag.health, last_seen: @tag.last_seen, light_rgb: @tag.light_rgb, name: @tag.name, origin: @tag.origin, speed: @tag.speed, tag_id: @tag.tag_id, type: @tag.type } }
    assert_redirected_to tag_url(@tag)
  end

  test "should destroy tag" do
    assert_difference('Tag.count', -1) do
      delete tag_url(@tag)
    end

    assert_redirected_to tags_url
  end
end
