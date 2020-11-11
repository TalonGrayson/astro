# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Tag Index view', js: true do

  shared_context 'generic setup' do
    let!(:tags_list) { FactoryBot.create_list(:tag, 10) }
  end

  context 'navigating to index' do
    scenario 'takes the user to the correct page' do
      given_the_user_is_logged_in
      when_the_user_navigates_to(tags_path)
      then_they_can_access(tags_path)
    end
  end

  context 'when there are no tags' do
    scenario 'the "no tags" message is shown' do
      given_the_user_is_logged_in
      when_the_user_navigates_to(tags_path)
      then_they_are_shown_the_message('No tags! Why not scan one?')
    end
  end

  context 'when there are tags' do
    include_context 'generic setup'
    scenario 'the tags table is shown' do
      given_the_user_is_logged_in
      when_the_user_navigates_to(tags_path)
      then_the_tags_table_is_present
    end
  end

end
