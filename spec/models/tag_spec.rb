# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do

  context 'database columns' do
    it { should have_db_column(:id).of_type :integer }
    it { should have_db_column(:tag_hex).of_type :string }
    it { should have_db_column(:origin).of_type :string }
    it { should have_db_column(:variety).of_type :string }
    it { should have_db_column(:name).of_type :string }
    it { should have_db_column(:light_rgb).of_type :string }
    it { should have_db_column(:health).of_type :integer }
    it { should have_db_column(:defence).of_type :integer }
    it { should have_db_column(:attack).of_type :integer }
    it { should have_db_column(:speed).of_type :integer }
    it { should have_db_column(:last_seen).of_type :datetime }
    it { should have_db_column(:deleted).of_type :boolean }
  end

  context 'with all attributes' do

    let(:tag) { FactoryBot.create(:tag) }

    it 'is valid' do
      expect(tag).to be_valid
    end

  end

  context 'scopes' do
    context 'active' do

      let(:active_tag_count) { Faker::Number.between(from: 3, to: 10) }
      let(:inactive_tag_count) { Faker::Number.between(from: 3, to: 10) }

      let!(:active_tags) { FactoryBot.create_list(:tag, active_tag_count) }
      let!(:inactive_tags) { FactoryBot.create_list(:tag, inactive_tag_count, :deleted) }

      let(:scoped_tags) { Tag.active }

      it 'only returns active tags' do

        expect(scoped_tags.count).to eq active_tag_count
        expect(scoped_tags.map(&:deleted).uniq).to eq [false]

      end

    end
  end

  context '#clean_light_rgb' do

    context 'with hex as input' do
      let(:input) { Faker::Color.hex_color }

      let(:user) { FactoryBot.create(:user) }
      let!(:tag) { FactoryBot.build(:tag, light_rgb: input, user: user) }

      let(:converted_rgb) { ColorConverter.rgb(input)}
      let!(:rgb_string) { "#{converted_rgb[0]},#{converted_rgb[1]},#{converted_rgb[2]}" }

      it 'converts the input to rgb' do
        tag.save
        tag.reload

        expect(tag.light_rgb).to eq rgb_string
      end

    end

    context 'without hex as input' do
      let(:input) do
        "#{Faker::Color.rgb_color[0]},#{Faker::Color.rgb_color[1]},#{Faker::Color.rgb_color[2]}"
      end

      let(:user) { FactoryBot.create(:user) }

      let!(:tag) { FactoryBot.build(:tag, light_rgb: input, user: user) }

      it 'does not mutate the input' do
        tag.save
        tag.reload

        expect(tag.light_rgb).to eq input
      end
    end

  end

end
