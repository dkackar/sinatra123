require 'spec_helper'


describe 'Game view' do

  # Before each test
  # we will visit
  # the root URL of the game
  before do
    visit '/'
  end

  # ----------------------------------------
  # Game Play
  # ----------------------------------------

  describe 'game play' do

    it 'begins with all disks in the left most tower' do
      expect(page).to have_css('.tower-1 .disk', :count => 3)
      expect(page).to_not have_css('.tower-2 .disk')
      expect(page).to_not have_css('.tower-3 .disk')
    end


    context 'moving' do

      it 'puts a disk into the correct tower when input is valid' do
        make_move(1, 3)
        expect(page).to have_css('.tower-3 .disk-1', :count => 1)
        expect(page).to have_css('.tower-1 .disk-2', :count => 1)
        expect(page).to have_css('.tower-1 .disk-3', :count => 1)
      end


      it 'does not change disk position when a tower number is invalid' do
        make_move(1, 0)
        expect(page).to have_css('.tower-1 .disk-1', :count => 1)
        expect(page).to have_css('.tower-1 .disk-2', :count => 1)
        expect(page).to have_css('.tower-1 .disk-3', :count => 1)
      end


      it 'does not change disk position when moving a larger disk on to a smaller disk' do
        make_move(1, 3)
        make_move(1, 3)
        expect(page).to have_css('.tower-3 .disk-1', :count => 1)
        expect(page).to have_css('.tower-1 .disk-2', :count => 1)
        expect(page).to have_css('.tower-1 .disk-3', :count => 1)
      end


      it 'does not change disk position when moving from an empty tower' do
        make_move(1, 3)
        make_move(2, 3)
        expect(page).to have_css('.tower-3 .disk-1', :count => 1)
        expect(page).to have_css('.tower-1 .disk-2', :count => 1)
        expect(page).to have_css('.tower-1 .disk-3', :count => 1)
      end


      it 'does not change disk position when moving from the same tower' do
        make_move(1, 1)
        expect(page).to have_css('.tower-1 .disk-1', :count => 1)
        expect(page).to have_css('.tower-1 .disk-2', :count => 1)
        expect(page).to have_css('.tower-1 .disk-3', :count => 1)
      end
    end
  end
end