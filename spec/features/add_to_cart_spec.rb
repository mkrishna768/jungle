require 'rails_helper'

RSpec.feature "Visitor clicks on Add to cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )

    end
  end

  scenario "and item is added to cart" do
    # ACT
    visit root_path
    page.first("article.product").hover
    page.first(:button, "Add").click
    
    # DEBUG
    #save_screenshot

    # VERIFY
    expect(page).to have_text 'My Cart (1)'
  end
end
