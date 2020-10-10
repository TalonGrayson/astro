require "application_system_test_case"

class TagsTest < ApplicationSystemTestCase
  setup do
    @tag = tags(:one)
  end

  test "visiting the index" do
    visit tags_url
    assert_selector "h1", text: "Tags"
  end

  test "creating a Tag" do
    visit tags_url
    click_on "New Tag"

    fill_in "Attack", with: @tag.attack
    fill_in "Defence", with: @tag.defence
    check "Deleted" if @tag.deleted
    fill_in "Health", with: @tag.health
    fill_in "Last seen", with: @tag.last_seen
    fill_in "Light rgb", with: @tag.light_rgb
    fill_in "Name", with: @tag.name
    fill_in "Origin", with: @tag.origin
    fill_in "Speed", with: @tag.speed
    fill_in "Tag", with: @tag.tag_id
    fill_in "Type", with: @tag.type
    click_on "Create Tag"

    assert_text "Tag was successfully created"
    click_on "Back"
  end

  test "updating a Tag" do
    visit tags_url
    click_on "Edit", match: :first

    fill_in "Attack", with: @tag.attack
    fill_in "Defence", with: @tag.defence
    check "Deleted" if @tag.deleted
    fill_in "Health", with: @tag.health
    fill_in "Last seen", with: @tag.last_seen
    fill_in "Light rgb", with: @tag.light_rgb
    fill_in "Name", with: @tag.name
    fill_in "Origin", with: @tag.origin
    fill_in "Speed", with: @tag.speed
    fill_in "Tag", with: @tag.tag_id
    fill_in "Type", with: @tag.type
    click_on "Update Tag"

    assert_text "Tag was successfully updated"
    click_on "Back"
  end

  test "destroying a Tag" do
    visit tags_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tag was successfully destroyed"
  end
end
