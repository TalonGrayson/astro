# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Tag Show view', js: true do

  shared_context 'generic setup' do
    let!(:tag) { FactoryBot.create(:tag) }
  end

  context 'when the tag does not exist' do
    scenario 'the user is shown the correct message' do
      given_the_user_is_logged_in
      when_the_user_navigates_to(tag_path(999))
      then_they_are_shown_the_message('That tag does not exist')
    end
  end

  context 'when the tag exists' do

    context 'without an image' do
      let!(:tag) { FactoryBot.create(:tag) }

      scenario 'the tag is correctly displayed' do
        given_the_user_is_logged_in
        when_the_user_navigates_to(tag_path(tag.id))
        then_the_tag_has_the_correct_info(tag)
        then_the_correct_tag_colour_is_shown(tag)
        then_the_correct_links_are_displayed
      end

      scenario 'the user can upload an image' do
        given_the_user_is_logged_in
        when_the_user_navigates_to(tag_path(tag.id))
        then_the_image_upload_field_is_present
        then_they_can_attach_an_image
      end

      scenario 'the user can navigate to the index' do
        given_the_user_is_logged_in
        when_the_user_navigates_to(tag_path(tag.id))
        then_they_can_navigate_via_link('#tags-link', tags_path)
      end

      scenario 'the user can navigate to edit' do
        given_the_user_is_logged_in
        when_the_user_navigates_to(tag_path(tag.id))
        then_they_can_navigate_via_link('#edit-tag-link', edit_tag_path(tag))
      end
    end

    context 'with an image' do
      let!(:tag) { FactoryBot.create(:tag, :with_image) }

      scenario 'the tag is correctly displayed' do
        given_the_user_is_logged_in
        when_the_user_navigates_to(tag_path(tag.id))
        then_the_tag_has_the_correct_info(tag)
        then_the_correct_tag_colour_is_shown(tag)
        then_the_correct_links_are_displayed
      end

      scenario 'the image is displayed' do
        given_the_user_is_logged_in
        when_the_user_navigates_to(tag_path(tag.id))
        then_the_image_upload_field_is_not_present
        then_the_image_is_displayed
      end

      scenario 'the user can navigate to the index' do
        given_the_user_is_logged_in
        when_the_user_navigates_to(tag_path(tag.id))
        then_they_can_navigate_via_link('#tags-link', tags_path)
      end

      scenario 'the user can navigate to edit' do
        given_the_user_is_logged_in
        when_the_user_navigates_to(tag_path(tag.id))
        then_they_can_navigate_via_link('#edit-tag-link', edit_tag_path(tag))
      end
    end

  end

end
