require File.expand_path '../spec_helper.rb', __FILE__

describe "environment variables" do
  before(:each) do
    @path = 'config/initializers/env.rb.example'
  end
  it "should be an example file" do
    expect(File.file?(@path)).to be true 
  end

  it "should be an example file with the env variables" do
    file = File.open(@path)
    file_data = file.readlines.map(&:chomp)
    expect(file_data[0]).to eq "ENV['BASE_URL'] = ''" 
    expect(file_data[1]).to eq "ENV['BEARER_TOKEN'] = ''" 
    expect(file_data[2]).to eq "ENV['URI_RSS'] = ''" 
  end
end
