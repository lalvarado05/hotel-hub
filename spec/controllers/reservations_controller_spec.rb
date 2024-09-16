require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:admin_user) { create(:user, role: 'admin') }
  let(:client_user) { create(:user, role: 'client') }
  let(:room) { create(:room) }
  let(:reservation) { create(:reservation, user: client_user, room: room) }

  before do
    sign_in admin_user
  end

  describe "GET #index" do
    context "when admin" do
      it "returns a successful response" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns all reservations to @reservations" do
        reservation
        get :index
        expect(assigns(:reservations)).to eq([reservation])
      end
    end

    context "when client" do
      before do
        sign_in client_user
      end

      it "assigns the current user's reservations to @reservations" do
        reservation
        get :index
        expect(assigns(:reservations)).to eq([reservation])
      end
    end
  end

end