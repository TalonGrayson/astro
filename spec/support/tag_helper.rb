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

  end
end

RSpec.configure do |config|
  config.include Astro::TagTestHelper, type: :feature
end