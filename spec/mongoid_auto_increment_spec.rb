require "spec_helper"

describe "mongoid_auto_increment" do

  before(:each) do
    @book1 = Book.create :name => "The Rails Way"
    @book2 = Book.create :name => "The Ruby Programming Language "
    @book3 = Book.create :name => "Metaprogramming Ruby"
    @order1 = Order.create :name => "First Order"
    @order2 = Order.create :name => "Second Order"
    @order3 = Order.create :name => "Last Order"
    @post1 = Post.create :name => "First Post"
    @post2 = Post.create :name => "Second Post"
    @post3 = Post.create :name => "Last Post"
    @comment1 = @post1.comments.create :name => "First Comment"
    @comment2 = @post1.comments.create :name => "Second Comment"
    @invoice1 = Invoice.create :name => "First invoice"
    @invoice2 = Invoice.create :name => "Second invoice"
    @invoice3 = Invoice.create :name => "Third invoice"
  end

  describe "single auto-increment field" do
    it "should have id 1" do
      expect(@book1.sequence).to eql 1
    end

    it "should have id 2" do
      expect(@book2.sequence).to eql 2
    end

    it "should have id 3" do
      expect(@book3.sequence).to eql 3
    end

    it "should have id 1" do
      expect(@comment1.idn).to eql 1
    end

    it "should have id 2" do
      expect(@comment2.idn).to eql 2
    end
  end

  describe "single auto-increment field with seed 1000" do
    it "should have id 1001" do
      expect(@order1.num).to eql 1001
    end

    it "should have id 1002" do
      expect(@order2.num).to eql 1002
    end

    it "should have id 1003" do
      expect(@order3.num).to eql 1003
    end
  end

  describe "two auto-increment fields" do
    it "should have id 1" do
      expect(@post1.key).to eql 501
    end

    it "should have id 2" do
      expect(@post2.key).to eql 502
    end

    it "should have id 3" do
      expect(@post3.key).to eql 503
    end

    it "should have id 1" do
      expect(@post1.num).to eql 1
    end

    it "should have id 2" do
      expect(@post2.num).to eql 2
    end

    it "should have id 3" do
      expect(@post3.num).to eql 3
    end
  end

  describe "auto-increment with step" do
    it "should have id 1005" do
      expect(@invoice1.num).to eq 1005
    end
    it "should have id 1010" do
      expect(@invoice2.num).to eq 1010
    end
    it "should have id 1015" do
      expect(@invoice3.num).to eq 1015
    end
  end
end
