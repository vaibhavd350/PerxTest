require 'rails_helper'
require 'spec_helper'

RSpec.describe API::V1::Rewards do

  let!(:gold_tier_user_one)     { create(:user, :gold_tier_user) }
  let!(:gold_tier_user_two)     { create(:user, :gold_tier_user) }
  let!(:standard_tier_user)     { create(:user, :standard_tier_user) }
  
  let!(:reward_one)             { create(:reward, :reward_one, user_id: gold_tier_user_one.id)}
  let!(:reward_two)             { create(:reward, :reward_two, user_id: gold_tier_user_two.id)}
  let!(:reward_three)           { create(:reward, :reward_three, user_id: gold_tier_user_two.id)}
  let!(:reward_four)            { create(:reward, :reward_four, user_id: gold_tier_user_two.id)}


  describe 'POST /api/rewards' do

    context 'when it is user birthday month' do
      it 'allows user to get a free coffee' do
        contact_rewards_endpoint('Free Coffee','birthday', standard_tier_user)
        expect(response).to be_successful
        expect(standard_tier_user.rewards.where(reward_type: 'birthday', name: 'Free Coffee').length).to eq(1)
      end

      it 'does not allow user to get more than one coffee under birthday reward type claim for that calendar year' do
        contact_rewards_endpoint('Free Coffee','birthday', gold_tier_user_one)
        expect(response).not_to be_successful
        expect(gold_tier_user_one.rewards.where(reward_type: 'birthday', name: 'Free Coffee').length).to eq(1)
      end
    end

    context 'when user has accumulated 100 points in one calendar month' do
      it 'allows user to get free coffee' do
        contact_rewards_endpoint('Free Coffee','points', gold_tier_user_one)
        expect(response).to be_successful
        expect(gold_tier_user_one.rewards.where(reward_type: 'points', name: 'Free Coffee').length).to eq(1)
      end

      it 'does not allow user to claim more than one free coffee under points reward type claim' do
        contact_rewards_endpoint('Free Coffee','points', gold_tier_user_two)
        expect(response).not_to be_successful
        expect(gold_tier_user_two.rewards.where(reward_type: 'points', name: 'Free Coffee').length).to eq(1)
      end
    end

    context 'when user has 10 or more transactions that have an amount > $100' do
      it 'allows user to claim cash rebate award' do
        contact_rewards_endpoint('Cash Rebate','points', gold_tier_user_one)
        expect(response).to be_successful
        expect(gold_tier_user_one.rewards.where(reward_type: 'points', name: 'Cash Rebate').length).to eq(1)
      end

      it 'does not allow to claim more than one cash rebate award' do
        contact_rewards_endpoint('Cash Rebate','points', gold_tier_user_two)
        expect(response).not_to be_successful
        expect(gold_tier_user_two.rewards.where(reward_type: 'points', name: 'Cash Rebate').length).to eq(1)
      end
    end

    context 'when new user has spending > $1000 within 60 days of their first transaction' do
      it 'allows user to claim movie ticket' do
        contact_rewards_endpoint('Movie Ticket','points', gold_tier_user_one)
        expect(response).to be_successful
        expect(gold_tier_user_one.rewards.where(reward_type: 'points', name: 'Movie Ticket').length).to eq(1)
      end

      it 'does not allow user to claim more than one movie ticket' do
        contact_rewards_endpoint('Movie Ticket','points', gold_tier_user_two)
        expect(response).not_to be_successful
        expect(gold_tier_user_two.rewards.where(reward_type: 'points', name: 'Movie Ticket').length).to eq(1)
      end
    end

  end

  private

  def contact_rewards_endpoint(reward_name, reward_type, user)
    post "/api/rewards", params: {name: reward_name, reward_type: reward_type}, headers: {'Authorization' => "#{user.authentication_token}"}
  end
end