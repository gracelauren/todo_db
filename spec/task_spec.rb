require('spec_helper')

describe(Task) do

  describe('#==') do
    it('is the same task if it has the same description') do
      task1 = Task.new({:description => 'learn SQL', :due => '2015-01-20 00:00:00', :list_id => 1})
      task2 = Task.new({:description => 'learn SQL', :due => '2015-01-20 00:00:00', :list_id => 1})
      expect(task1).to(eq(task2))
    end
  end

  describe('.all') do
    it("starts off with no tasks") do
      expect(Task.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('adds a task to the array of saved tasks') do
      test_task = Task.new({:description => 'learn SQL', :due => '2015-01-20 00:00:00', :list_id => 1})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

  describe('#due') do
    it('returns due date of task') do
      test_task = Task.new({:description => 'learn SQL', :due => '2015-01-20 00:00:00', :list_id => 1})
      test_task.save()
      expect(test_task.due()).to(eq("2015-01-20 00:00:00"))
    end
  end

  describe('#delete') do
    it("deletes task from database") do
      test_task = Task.new({:description => 'learn SQL', :due => '2015-01-20 00:00:00', :list_id => 1})
      test_task.save()
      test_task2 = Task.new({:description => 'learn ruby', :due => '2015-01-22 00:00:00', :list_id => 1})
      test_task2.save()
      test_task.delete()
      expect(Task.all()).to(eq([test_task2]))
    end
  end

  describe('.find') do
    it('returns a task by its ID number') do
      test_task = Task.new({:description => 'learn SQL', :due => '2015-01-20 00:00:00', :list_id => 1})
      test_task.save()
      test_task2 = Task.new({:description => 'learn ruby', :due => '2015-01-22 00:00:00', :list_id => 1})
      test_task2.save()
      expect(Task.find(test_task2.id())).to(eq(test_task2))
    end
  end

end
