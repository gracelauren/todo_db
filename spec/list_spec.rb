require('spec_helper')

describe(List) do

  describe(".all") do
    it("starts off with no lists") do
      expect(List.all()).to(eq([]))
    end
  end

  describe('#name') do
    it("returns its name") do
      list = List.new({ :name => "foo", :id => nil })
      expect(list.name()).to(eq("foo"))
    end
  end

  describe('#id') do
    it('sets its ID when you save it') do
      list = List.new({:name => 'foo', :id => nil})
      list.save()
      expect(list.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save') do
    it('lets you save lists to the database') do
      list = List.new({:name => 'foo', :id => nil})
      list.save()
      expect(List.all()).to(eq([list]))
    end
  end

  describe('#==') do
    it('is the same list if it has the same name') do
      list1 = List.new({ :name => "foo", :id => nil} )
      list2 = List.new({ :name => "foo", :id => nil} )
      expect(list1).to(eq(list2))
    end
  end

  describe('.find') do
    it('returns a list by its ID number') do
      test_list = List.new({:name => "Foo", :id => nil})
      test_list.save()
      test_list2 = List.new({:name => 'la', :id => nil})
      test_list2.save()
      expect(List.find(test_list2.id())).to(eq(test_list2))
    end
  end

  describe('#tasks') do

    it("returns a list of tasks that belong to that list") do
      test_list = List.new({ :name => "Foo", :id => nil })
      test_list.save()
      task1 = Task.new({:description => 'learn SQL', :due => '2015-01-20 00:00:00', :list_id => test_list.id()})
      task2 = Task.new({:description => 'drink coffee', :due => '2015-01-21 00:00:00', :list_id => test_list.id()})
      task1.save()
      task2.save()
      expect(test_list.tasks()).to(eq([task1, task2]))
    end

    it("returns a list of tasks that belong to that list, sorted by due date") do
      test_list = List.new({ :name => "Foo", :id => nil })
      test_list.save()
      task1 = Task.new({:description => 'learn SQL', :due => '2015-01-22 00:00:00', :list_id => test_list.id()})
      task2 = Task.new({:description => 'drink coffee', :due => '2015-01-20 00:00:00', :list_id => test_list.id()})
      task3 = Task.new({:description => 'code', :due => '2014-01-01 00:00:00', :list_id => test_list.id()})
      task1.save()
      task2.save()
      task3.save()
      expect(test_list.tasks()).to(eq([task3, task2, task1]))
    end

  end

  describe('#delete') do
    it("deletes a list from database") do
      test_list = List.new({ :name => "Foo", :id => nil })
      test_list.save()
      test_list2 = List.new({:name => 'la', :id => nil})
      test_list2.save()
      test_list.delete()
      expect(List.all()).to(eq([test_list2]))
    end
  end



end
