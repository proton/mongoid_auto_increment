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
      @book1.sequence.should eql 1
    end

    it "should have id 2" do
      @book2.sequence.should eql 2
    end

    it "should have id 3" do
      @book3.sequence.should eql 3
    end

    it "should have id 1" do
      @comment1.idn.should eql 1
    end

    it "should have id 2" do
      @comment2.idn.should eql 2
    end
  end

  describe "single auto-increment field with seed 1000" do
    it "should have id 1001" do
      @order1.num.should eql 1001
    end

    it "should have id 1002" do
      @order2.num.should eql 1002
    end

    it "should have id 1003" do
      @order3.num.should eql 1003
    end
  end

  describe "two auto-increment fields" do
    it "should have id 1" do
      @post1.key.should eql 501
    end

    it "should have id 2" do
      @post2.key.should eql 502
    end

    it "should have id 3" do
      @post3.key.should eql 503
    end

    it "should have id 1" do
      @post1.num.should eql 1
    end

    it "should have id 2" do
      @post2.num.should eql 2
    end

    it "should have id 3" do
      @post3.num.should eql 3
    end
  end

  describe "auto-increment with step" do
    it "should have id 1005" do
      @invoice1.num.should eq 1005
    end
    it "should have id 1010" do
      @invoice2.num.should eq 1010
    end
    it "should have id 1015" do
      @invoice3.num.should eq 1015
    end
  end
end
