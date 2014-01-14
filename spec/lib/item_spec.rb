require "spec_helper"
require "item"

describe Item do
  let(:html) { File.open('spec/html_fixture/item_info.html') }
  let(:item) { Item.new(html: html) }

  it "has html string" do
    expect(item.html).to eq(html)
  end

  it "has empty variants" do
    expect(item.variants).to eq([])
  end

  describe "parse!" do
    let(:brand_name) { "Petit Bateau" }
    let(:item_name) { "Beluga quilted mini skirt" }

    before do
      item.parse!
    end

    it "sets brand name" do
      expect(item.brand_name).to eq brand_name
    end

    it "sets item name" do
      expect(item.name).to eq item_name
    end

    it "sets variants" do
      expect(item.variants).to eq(["3 Month"])
    end
  end
end
