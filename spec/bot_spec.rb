require File.expand_path '../spec_helper.rb', __FILE__

describe Bot do
  before(:each) do
    ENV['URI_RSS'] = 'spec/feed.xml'
    @path_to_file = 'spec/db/out.txt'
    @bot = Bot.new('spec/db/out.txt')
    @time = Time.new(2020, 3, 4)
  end

  after(:each) do
    File.delete(@path_to_file) if File.exist?(@path_to_file)
  end

  describe '#last_date' do
    it "should return the last stored date" do
      @bot.add_last_date(@time)
      expect(@bot.last_date).to eq @time
    end
  end

  describe "find and return date" do
    before(:each) do
      @array = []
      for i in 1..10
        @bot.add_last_date(Time.new(2020, 4, i))
        @array << @bot.last_date
      end
    end

    describe "#lasted_publications" do
      for i in 1..10 
        it "should return the last #{i} publications" do
          expect(@bot.lasted_publications(i)).to eq @array.reverse.first(i)
        end
      end
    end

    describe "#find_pub_date" do
      it "It should return true if it finds the date" do
        expect(@bot.find_pub_date(@array.first)).to be true
      end

      it "It should return false if not it finds the date" do
        expect(@bot.find_pub_date(Time.new(2021, 4, 2))).to be false
      end
    end
  end

  describe "#create_toot" do
    it "the created toots should be different from the previous toots" do
      publiction_1 = @bot.create_toot
      publiction_2 = @bot.create_toot
      expect(publiction_1).not_to eq(publiction_2)
    end 
  end
end