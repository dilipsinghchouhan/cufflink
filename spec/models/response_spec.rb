require "spec_helper"

describe Response do
  
  describe "#is_like?" do
    
    it "detects a comment" do
      comment = Response.new
      comment.body = "Comment text!"
      
      expect(comment.is_like?).to be_false
    end
    
    it "detects a like" do
      like = Response.new
      
      expect(like.is_like?).to be_true
    end
    
  end
end