require 'spec_helper'

describe Status do
  
  describe "#link_is_ok" do
    
    it "rejects bad links" do
      
      status = Status.new(link: "http:google.com")
      
      status.valid?
      expect(status.errors.messages[:link])
        .to eq(["Please enter a valid URL"])
      
    end
  end
  
  describe "#excerpt" do
    
    it "takes the excerpt of a comment with a body" do
      
      status = Status.new(body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
      
      expect(status.excerpt).to eq("status: <div>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore</div>")
    end
    
    it "takes the excerpt of a comment with a body and a link" do
      
      status = Status.new(body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", link: "http://www.google.com")
      
      expect(status.excerpt).to eq("status: <div>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore</div>")
    end
    
    it "takes the excerpt of a comment with a link" do
      
      status = Status.new(link: "http://www.google.com")
      
      expect(status.excerpt)
        .to eq("status: <div>http://www.google.com</div>")
    end
    
    it "handles a comment with just an image" do
      
      status = Status.new
      status.pic_file_name = "bob.png"
      
      expect(status.excerpt).to eq("photo status")
    end
  end
end