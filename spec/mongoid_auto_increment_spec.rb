require "spec_helper"

describe "mongoid_auto_increment" do

  before(:each) do
    @book1 = Book.create :name => "The Rails Way"
    @book2 = Book.create :name => "The Ruby Programming Language "
    @book3 = Book.create :name => "Metaprogramming Ruby"
    @order1 = Order.create :name => "First Order"
    @order2 = Order.create :name => "Second Order"
    @order3 = Order.create :name => "Last Order"
  end

  it "should have id 1" do
    @book1.sequence.should eql 1
  end

  it "should have id 2" do
    @book2.sequence.should eql 2
  end

  it "should have id 3" do
    @book3.sequence.should eql 3
  end

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