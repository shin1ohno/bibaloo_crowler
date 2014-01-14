require "spec_helper"
require "item"

describe Item do
  let(:html) { File.open('spec/html_fixture/item_info.html') }
  let(:item) { Item.new(html: html) }

  it "has empty variants" do
    expect(item.variants).to eq([])
  end

  describe "parse!" do
    let(:brand_name) { "Petit Bateau" }
    let(:item_name) { "SS striped pocket tunic dress" }

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
      expect(item.variants).to eq(["3 Year", "4 Year", "5 Year", "6 Year"])
    end

    it "sets detail url" do
      expect(item.detail_url).to eq("http://www.bibaloo.com/item/PetitBateau_DressesSkirts_SSstripedpockettunicdress_0_59_10393_0.html")
    end
  end
end
