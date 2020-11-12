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

    def then_the_correct_tag_colour_is_shown(tag)
      card = find_by_id('tag-card')
      split_colour = tag.light_rgb.split(',')
      expected_colour = "#{split_colour[0]}, #{split_colour[1]}, #{split_colour[2]}"
      expected_style = "box-shadow: rgb(#{expected_colour}) 0px 0px 40px 0px;"
      expect(card[:style]).to eq expected_style
    end

    def then_the_correct_links_are_displayed
      expect(page).to have_link '', href: tags_path
      expect(page).to have_link '', href: edit_tag_path(tag.id)
      expect(page).to have_link '', href: trigger_tag_tag_path(tag.id)
    end

    def then_the_image_upload_field_is_present
      expect(page).to have_field 'tag[tag_image]'
      expect(page).to have_selector('#submit')
    end

    def then_the_image_upload_field_is_not_present
      expect(page).to have_no_field 'tag[tag_image]'
      expect(page).to have_no_selector('#submit')
    end

    def then_they_can_attach_an_image
      page.attach_file(file_fixture('hunk.jpg'))
      find('#submit').click
      expect(page).to have_no_field('tag[tag_image]')
    end

    def then_the_image_is_displayed
      expect(page).to have_css("img[src*='hunk.jpg']")
    end

    def then_they_can_navigate_via_link(link, given_path)
      find(link).click
      then_they_can_access(given_path)
    end

  end
end

RSpec.configure do |config|
  config.include Astro::TagTestHelper, type: :feature
end