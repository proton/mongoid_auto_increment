require 'spec_helper'

describe 'mongoid_auto_increment' do

  before(:each) do
    @book1 = Book.create :name => 'The Rails Way'
    @book2 = Book.create :name => 'The Ruby Programming Language '
    @book3 = Book.create :name => 'Metaprogramming Ruby'
    @order1 = Order.create :name => 'First Order'
    @order2 = Order.create :name => 'Second Order'
    @order3 = Order.create :name => 'Last Order'
    @post1 = Post.create :name => 'First Post'
    @post2 = Post.create :name => 'Second Post'
    @post3 = Post.create :name => 'Last Post'
    @comment1 = @post1.comments.create :name => 'First Comment'
    @comment2 = @post1.comments.create :name => 'Second Comment'
    @invoice1 = Invoice.create :name => 'First invoice'
    @invoice2 = Invoice.create :name => 'Second invoice'
    @invoice3 = Invoice.create :name => 'Third invoice'
    @record1 = Record.create :name => 'First record'
    @record2 = Record.create :name => 'Second record'
    @record3 = Record.create :name => 'Third record'
  end

  describe 'single auto-increment field' do
    it 'should have id 1' do
      expect(@book1.sequence).to eql 1
    end

    it 'should have id 2' do
      expect(@book2.sequence).to eql 2
    end

    it 'should have id 3' do
      expect(@book3.sequence).to eql 3
    end

    it 'should have id 1' do
      expect(@comment1.idn).to eql 1
    end

    it 'should have id 2' do
      expect(@comment2.idn).to eql 2
    end
  end

  describe 'single auto-increment field with seed 1000' do
    it 'should have id 1001' do
      expect(@order1.num).to eql 1001
    end

    it 'should have id 1002' do
      expect(@order2.num).to eql 1002
    end

    it 'should have id 1003' do
      expect(@order3.num).to eql 1003
    end
  end

  describe 'two auto-increment fields' do
    it 'should have id 1' do
      expect(@post1.key).to eql 501
    end

    it 'should have id 2' do
      expect(@post2.key).to eql 502
    end

    it 'should have id 3' do
      expect(@post3.key).to eql 503
    end

    it 'should have id 1' do
      expect(@post1.num).to eql 1
    end

    it 'should have id 2' do
      expect(@post2.num).to eql 2
    end

    it 'should have id 3' do
      expect(@post3.num).to eql 3
    end
  end

  describe 'auto-increment with step' do
    it 'should have id 1005' do
      expect(@invoice1.num).to eq 1005
    end
    it 'should have id 1010' do
      expect(@invoice2.num).to eq 1010
    end
    it 'should have id 1015' do
      expect(@invoice3.num).to eq 1015
    end
  end

  describe 'auto-increment with name' do
    def collection
      coll_name = 'sequences'

      if defined?(::Mongoid::VERSION) && ::Mongoid::VERSION >= '5'
        Mongoid.default_client[coll_name]
      elsif defined?(::Mongoid::VERSION) && ::Mongoid::VERSION >= '3'
        Mongoid.default_session[coll_name]
      else
        Mongoid.database[coll_name]
      end
    end

    it 'should have id 1' do
      expect(@record1.id2).to eq 1
    end
    it 'should have id 2' do
      expect(@record2.id2).to eq 2
    end
    it 'should have id 3' do
      expect(@record3.id2).to eq 3
    end

    it 'should have a sequence name of "Record"' do
      expect(collection.find(:seq_name => 'Record').first).not_to eq nil
    end
  end

  describe 'auto-increment with scope' do
    context 'when scope is a relation' do
      before do
        @recipe1 = Recipe.create
        @recipe2 = Recipe.create
      end

      it 'should have multiple with the same value' do
        expect(@recipe1.ingredients.create.order).to eq 1
        expect(@recipe2.ingredients.create.order).to eq 1
      end

      it 'should increment each scope separately' do
        3.times.each{ |n| @recipe1.ingredients.create(name: n + 1) }
        9.times.each{ |n| @recipe2.ingredients.create(name: n + 1) }
        expect(Ingredient.find_by(recipe: @recipe2, name: 3).order).to eq 3
        expect(Ingredient.find_by(recipe: @recipe2, name: 9).order).to eq 9
      end
    end

    context 'when scope is a field' do
      it 'should have multiple with the same value' do
        expect(Recipe.create(chef: 'Jack').rank).to eq 1
        expect(Recipe.create(chef: 'Jill').rank).to eq 1
      end

      it 'should increment each scope separately' do
        3.times.each{ |n| Recipe.create(chef: 'Jack', name: n + 1) }
        9.times.each{ |n| Recipe.create(chef: 'Jill', name: n + 1) }
        expect(Recipe.find_by(chef: 'Jack', name: 3).rank).to eq 3
        expect(Recipe.find_by(chef: 'Jill', name: 9).rank).to eq 9
      end
    end

    context 'when scope is an array' do
      before do
        @recipe1 = Recipe.create
        @recipe2 = Recipe.create
      end

      it 'should have multiple with the same value' do
        expect(Ingredient.create(recipe: @recipe1, type: 'greens').cost).to eq 1
        expect(Ingredient.create(recipe: @recipe1, type: 'meats').cost).to eq 1
        expect(Ingredient.create(recipe: @recipe2, type: 'greens').cost).to eq 1
      end

      it 'should increment each scope separately' do
        2.times.each{ |n| Ingredient.create(recipe: @recipe1, type: 'greens', name: n + 1) }
        3.times.each{ |n| Ingredient.create(recipe: @recipe1, type: 'meats', name: n + 1) }
        5.times.each{ |n| Ingredient.create(recipe: @recipe2, type: 'greens', name: n + 1) }
        expect(Ingredient.find_by(recipe: @recipe1, type: 'greens', name: 2).cost).to eq 2
        expect(Ingredient.find_by(recipe: @recipe1, type: 'meats', name: 3).cost).to eq 3
        expect(Ingredient.find_by(recipe: @recipe2, type: 'greens', name: 5).cost).to eq 5
      end
    end
  end
end
