class CreateHierarchy < ActiveRecord::Migration
  def up
        g1 = Country.create(:name => "India")
    g2 = Country.create(:name => "USA")
    g3 = Country.create(:name => "Australia")

    a1 = State.create(:name => "Maharashtra", :country_id => g1.id)
    a2 = State.create(:name => "Andra pradesh", :country_id => g1.id)
    a3 = State.create(:name => "New York", :country_id => g2.id)
    a4 = State.create(:name => "Washinton", :country_id => g2.id)
    a5 = State.create(:name => "Sydney", :country_id => g3.id)
    a6 = State.create(:name => "Brisban", :country_id => g3.id)

    City.create(:name => "Song 1",  :state_id => a1.id)
    City.create(:name => "Song 2",  :state_id => a1.id)
    City.create(:name => "Song 3",  :state_id => a2.id)
    City.create(:name => "Song 4",  :state_id => a2.id)
    City.create(:name => "Song 5",  :state_id => a3.id)
    City.create(:name => "Song 6",  :state_id => a3.id)
    City.create(:name => "Song 7",  :state_id => a4.id)
    City.create(:name => "Song 8",  :state_id => a4.id)
    City.create(:name => "Song 9",  :state_id => a5.id)
    City.create(:name => "Song 10", :state_id => a5.id)
    City.create(:name => "Song 11", :state_id => a6.id)
    City.create(:name => "Song 12", :state_id => a6.id)
  end

  def down
  end
end
