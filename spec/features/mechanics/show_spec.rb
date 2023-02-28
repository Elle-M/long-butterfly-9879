require 'rails_helper'

describe 'mechanic show page' do
  before(:each) do
    @amusement_park = AmusementPark.create!(name: 'Six Flags', admission_cost: 75) 

    @mechanic1 = Mechanic.create!(name: 'Kara Smith', years_experience: 11)
    @mechanic2 = Mechanic.create!(name: 'Nancy Reagan', years_experience: 8)
    @mechanic3 = Mechanic.create!(name: 'Neil Armstrong', years_experience: 15)

    @ride1 = Ride.create!(name: 'The Hurler', thrill_rating: 7, open: false)
    @ride2 = Ride.create!(name: 'Zipper', thrill_rating: 6, open: true)
    @ride3 = Ride.create!(name: 'Rollar Coaster', thrill_rating: 10, open: false)
    @ride4 = Ride.create!(name: 'Tea Cups', thrill_rating: 1, open: true)

    @mechanic_rides1 = MechanicRide.create!(mechanic: @mechanic1, ride: @ride1)
    @mechanic_rides1 = MechanicRide.create!(mechanic: @mechanic2, ride: @ride2)
    @mechanic_rides1 = MechanicRide.create!(mechanic: @mechanic3, ride: @ride3)
    @mechanic_rides1 = MechanicRide.create!(mechanic: @mechanic4, ride: @ride4)
  end

  describe 'user story 1' do
    it 'displays their name, years of experience, and the names of all rides they are working on' do
      visit mechanic_path(@mechanic1)

      within(".mechanic") do
      expect(page).to have_content("Mechanic Name: Kara Smith")
      expect(page).to_not have_content("Mechanic Name: Nancy Reagan")
      expect(page).to have_content("Years of Experience: 11")
      expect(page).to_not have_content("Years of Experience: 8")
      expect(page).to have_content("Current Rides: The Hurler")
      expect(page).to_not have_content("Current Rides: Zipper")
    end
  end

  describe 'user story 2' do
    it 'has a form to add a ride to their workload' do
      visit mechanic_path(@mechanic1)

      within(".mechanic") do
        expect(page).to have_content("The Hurler")
        expect(page).to_not have_content("Zipper")
        expect(page).to_not have_content("Rollar Coaster")
        expect(page).to_not have_content("Tea Cups")
      end  
    end

    it 'has a field to add an id of an existing ride and click Submit' do
      visit mechanic_path(@mechanic1)

      within("#add-ride") do
        expect(page).to have_field("Add Ride")
        fill_in("Add Ride", with: ride2.id )
        click_button("Add Ride")
      end

      expect(current_path).to eq(mechanic_path(mechanic1))
      expect(page).to have_content("The Hurler")
      expect(page).to have_content("Zipper")
      expect(page).to_not have_content("Rollar Coaster")
    end
  end
end

