require 'rails_helper'

RSpec.describe "Submissions", type: :request do
  let!(:user) {FactoryBot.create(:user)}
  let!(:submission) {FactoryBot.create_list(:submission, 2, user: user)}

  
end
