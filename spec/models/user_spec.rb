require 'rails_helper'

RSpec.describe User, type: :model do

  context 'database columns' do
    it { should have_db_column(:id).of_type :integer }
    it { should have_db_column(:email).of_type :string }
    it { should have_db_column(:encrypted_password).of_type :string }
    it { should have_db_column(:reset_password_token).of_type :string }
    it { should have_db_column(:reset_password_sent_at).of_type :datetime }
    it { should have_db_column(:remember_created_at).of_type :datetime }
    it { should have_db_column(:provider).of_type :string }
    it { should have_db_column(:uid).of_type :string }
    it { should have_db_column(:name).of_type :string }
    it { should have_db_column(:description).of_type :string }
    it { should have_db_column(:image).of_type :string }
    it { should have_db_column(:admin).of_type :boolean }
  end
end
