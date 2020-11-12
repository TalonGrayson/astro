# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Tag Edit view', js: true do

  shared_context 'generic setup' do
    let!(:tag) { FactoryBot.create(:tag) }
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
