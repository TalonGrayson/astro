# frozen_string_literal: true

module Astro
  module TagTestHelper

    # Given
    def given_the_user_is_logged_in
      # we don't have users yet
    end

    # When
    def when_the_user_navigates_to(given_path)
      visit given_path
    end

    # And
    def and_they_attach_an_image

    end

    # Then
    def then_they_can_access(given_path)
      expect(current_path).to eq given_path
    end

    def then_they_are_shown_the_message(message)
      expect(page).to have_text message
    end

    def then_the_tags_table_is_present
      expect(page).to have_table('tags-table')
    end

    def then_the_tag_has_the_correct_info(tag)
      expect(page).to have_text tag.name
      expect(page).to have_text tag.health
      expect(page).to have_text tag.attack
      expect(page).to have_text tag.defence
      expect(page).to have_text tag.speed
    end

    def then_the_tag_has_the_correct_fields(tag)
      hex_colour = Chroma.paint("rgb(#{tag.light_rgb})").to_hex
      expect(page).to have_field 'tag[name]', with: tag.name
      expect(page).to have_field 'tag[origin]', with: tag.origin
      expect(page).to have_field 'tag[variety]', with: tag.variety
      expect(page).to have_field 'tag[light_rgb]', with: hex_colour
    end

    def then_the_correct_tag_colour_is_shown(tag)
      card            = find_by_id('tag-card')
      split_colour    = tag.light_rgb.split(',')
      expected_colour = "#{split_colour[0]}, #{split_colour[1]}, #{split_colour[2]}"
      expected_style  = "box-shadow: rgb(#{expected_colour}) 0px 0px 40px 0px;"
      expect(card[:style]).to eq expected_style
    end

    def then_the_correct_links_are_displayed(given_view)
      if given_view == 'show'
        expect(page).to have_link '', href: tags_path
        expect(page).to have_link '', href: edit_tag_path(tag.id)
        expect(page).to have_link '', href: trigger_tag_tag_path(tag.id)
      elsif given_view == 'edit'
        expect(page).to have_link '', href: tags_path
        expect(page).to have_link '', href: tag_path(tag.id)
        expect(page).to have_link '', href: soft_delete_tag_path(tag.id)
      end
    end

    def then_the_image_upload_field_is_present
      expect(page).to have_field 'tag[tag_image]'
      expect(page).to have_selector('#submit-tag-link')
    end

    def then_the_image_upload_field_is_not_present
      expect(page).to have_no_field 'tag[tag_image]'
    end

    def then_the_submit_button_is_not_present
      expect(page).to have_no_selector('#submit-tag-link')
    end

    def then_they_can_attach_an_image
      page.attach_file(file_fixture('hunk.jpg'))
      find('#submit-tag-link').click
      expect(page).to have_no_field('tag[tag_image]')
    end

    def then_the_image_is_displayed
      expect(page).to have_css("img[src*='hunk.jpg']")
    end

    def then_they_can_navigate_via_link(link, given_path)
      find(link).click
      then_they_can_access(given_path)
    end

    def then_they_can_edit_the_tag(tag)
      new_name    = Faker::Coffee.blend_name.strip
      new_origin  = Faker::Coffee.origin.strip
      new_variety = Faker::Coffee.variety.strip
      new_rgb     = "#{Faker::Number.between(from: 0, to: 255)},#{Faker::Number.between(from: 0, to: 255)},#{Faker::Number.between(from: 0, to: 255)}"
      new_hex     = Chroma.paint("rgb(#{new_rgb})").to_hex
      fill_in 'Name', with: new_name
      fill_in 'Origin', with: new_origin
      fill_in 'Variety', with: new_variety
      fill_in 'Light Colour', with: new_hex
      find('#submit-tag-link').click

      expect(Tag.count).to eq 1
      expect(page).to have_text "#{new_name} was successfully updated."
      updated_tag = Tag.first
      expect(updated_tag.name).to eq new_name
      expect(updated_tag.origin).to eq new_origin
      expect(updated_tag.variety).to eq new_variety
      expect(updated_tag.light_rgb).to eq new_rgb
    end

    def then_they_can_delete_the_tag(tag)
      accept_confirm do
        find('#soft-delete-tag-link').click
      end
      expect(current_path).to eq soft_delete_tag_path(tag.id)
      expect(page).to have_text "#{tag.name} was successfully deleted."
      tag.reload
      expect(tag.deleted).to eq true
    end

  end
end

RSpec.configure do |config|
  config.include Astro::TagTestHelper, type: :feature
end