require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  let(:valid_attributes) do
    { name: 'Test', description: 'This is a <b>test</b>' }
  end
  let(:invalid_attributes) do
    { name: '', description: 'This is a <b>test</b>' }
  end

  before do
    user.confirm
    sign_in user
  end

  describe 'GET #index' do
    it 'gets all the cards and assigns them to @cards' do
      card = Card.create(valid_attributes)
      get :index

      expect(assigns(:cards)).to eq([card])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested card to @card' do
      card = Card.create(valid_attributes)
      get :show, id: card.to_param

      expect(assigns(:card)).to eq(card)
    end
  end

  describe 'GET #new' do
    it 'assigns a new card as @card' do
      get :new, {}
      expect(assigns(:card)).to be_a_new(Card)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested card as @card' do
      card = Card.create! valid_attributes
      get :edit, id: card.to_param
      expect(assigns(:card)).to eq(card)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Card' do
        expect { post :create, card: valid_attributes }
            .to change(Card, :count).by(1)
      end

      it 'assigns a newly created card as @card' do
        post :create, card: valid_attributes
        expect(assigns(:card)).to be_a(Card)
        expect(assigns(:card)).to be_persisted
      end

      it 'redirects to the created card' do
        post :create, card: valid_attributes
        expect(response).to redirect_to(Card.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved Card as @card' do
        post :create, card: invalid_attributes
        expect(assigns(:card)).to be_a_new(Card)
      end

      it 're-renders the new template' do
        post :create, card: invalid_attributes
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'Test-updated', description: 'Updating description' }
      end

      it 'updates the requested card' do
        card = Card.create! valid_attributes
        put :update, id: card.to_param, card: new_attributes
        card.reload
      end

      it 'assigns the requested card as @card' do
        card = Card.create! valid_attributes
        put :update, id: card.to_param, card: valid_attributes
        expect(assigns(:card)).to eq(card)
      end

      it 'redirects to root because user does not own the card' do
        card = Card.create! valid_attributes
        put :update, id: card.to_param, card: valid_attributes
        expect(flash[:alert]).to eq(I18n.t('controllers.cards.check_own!.not_your_card'))
        expect(response).to redirect_to(card)
      end

      it 'redirects to card' do
        card = user.cards.create! valid_attributes
        put :update, id: card.to_param, card: valid_attributes
        expect(response).to redirect_to(card)
      end
    end

    context 'with invalid params' do
      it 'assigns the card as @card' do
        card = Card.create! valid_attributes
        put :update, id: card.to_param, card: invalid_attributes
        expect(assigns(:card)).to eq(card)
      end

      it 're-renders the edit template' do
        card = user.cards.create! valid_attributes
        put :update, id: card.to_param, card: invalid_attributes
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'does not the requested card' do
      card = Card.create! valid_attributes
      expect { delete :destroy, id: card.to_param }
          .to change(Card, :count).by(0)
    end

    it 'redirects to the card list' do
      card = Card.create! valid_attributes
      delete :destroy, id: card.to_param
      expect(flash[:alert]).to eq(I18n.t('controllers.cards.check_own!.not_your_card'))
      expect(response).to redirect_to(card)
    end
  end
end
