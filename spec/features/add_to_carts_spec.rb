require 'rails_helper'

RSpec.feature "Visitor adds a product to the cart", type: :feature, js: true do
  
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

  scenario "They see 'My Cart' incremented by 1" do
    # ACT
    visit root_path
    
    first('article.product').find_link('Add').click
    
    # DEBUG / VERIFY
    expect(page).to have_xpath("//a[contains(.,'My Cart (1)')]")
  end

end
