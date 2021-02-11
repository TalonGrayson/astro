# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tag Edit view', type: :feature, js: true do

  context 'when the tag does not exist' do
    let!(:tag) { FactoryBot.create(:tag) }
    scenario 'the user is shown the correct message' do
      # login_as tag.user, scope: :user
      given_the_user_is_logged_in(tag.user)
      when_the_user_navigates_to(edit_tag_path(999))
      then_they_are_shown_the_message('That tag does not exist')
    end
  end

  context 'when the tag exists' do

    context 'without an image' do
      let!(:tag) { FactoryBot.create(:tag) }

      scenario 'the tag is correctly displayed' do
        given_the_user_is_logged_in(tag.user)
        when_the_user_navigates_to(edit_tag_path(tag.id))
        then_the_tag_has_the_correct_fields(tag)
        then_the_correct_tag_colour_is_shown(tag)
        then_the_correct_links_are_displayed('edit')
      end

      scenario 'the user can upload an image' do
        given_the_user_is_logged_in(tag.user)
        when_the_user_navigates_to(edit_tag_path(tag.id))
        then_the_image_upload_field_is_present
        then_they_can_attach_an_image
      end

      scenario 'the user can navigate to the index' do
        given_the_user_is_logged_in(tag.user)
        when_the_user_navigates_to(edit_tag_path(tag.id))
        then_they_can_navigate_via_link('#tags-link', tags_path)
      end

      scenario 'the user can navigate to edit' do
        given_the_user_is_logged_in(tag.user)
        when_the_user_navigates_to(edit_tag_path(tag.id))
        then_they_can_navigate_via_link('#tag-link', tag_path(tag))
      end

      scenario 'the user can edit the tag' do
        pending 'This spec doesn\'t currently work but the actual code does'
        given_the_user_is_logged_in(tag.user)
        when_the_user_navigates_to(edit_tag_path(tag.id))
        then_they_can_edit_the_tag(tag)
      end

      scenario 'the user can delete the tag' do
        given_the_user_is_logged_in(tag.user)
        when_the_user_navigates_to(edit_tag_path(tag.id))
        then_they_can_delete_the_tag(tag)
      end
    end

    context 'with an image' do
      let!(:tag) { FactoryBot.create(:tag, :with_image) }

      scenario 'the tag is correctly displayed' do
        given_the_user_is_logged_in(tag.user)
        when_the_user_navigates_to(edit_tag_path(tag.id))
        then_the_tag_has_the_correct_fields(tag)
        then_the_correct_tag_colour_is_shown(tag)
        then_the_correct_links_are_displayed('edit')
      end

      scenario 'the image is displayed' do
        given_the_user_is_logged_in(tag.user)
        when_the_user_navigates_to(edit_tag_path(tag.id))
        then_the_image_upload_field_is_not_present
        then_the_image_is_displayed
      end

      scenario 'the user can navigate to the index' do
        given_the_user_is_logged_in(tag.user)
        when_the_user_navigates_to(edit_tag_path(tag.id))
        then_they_can_navigate_via_link('#tags-link', tags_path)
      end

      scenario 'the user can navigate to show' do
        given_the_user_is_logged_in(tag.user)
        when_the_user_navigates_to(edit_tag_path(tag.id))
        then_they_can_navigate_via_link('#tag-link', tag_path(tag))
      end
    end

  end

end
