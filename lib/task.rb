class Task

  attr_reader(:description, :due, :list_id)

  define_method(:==) do |another_task|
    self.description() == another_task.description() && self.list_id() == another_task.list_id() && self.due() == another_task.due()
  end

  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @list_id = attributes.fetch(:list_id)
    @due = attributes.fetch(:due)
  end

  define_singleton_method(:all) do
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch('description')
      list_id = task.fetch('list_id').to_i()
      due = task.fetch('due')
      tasks.push(Task.new({:description => description, :due => due, :list_id => list_id}))
    end
    tasks
  end

  define_method(:save) do
    DB.exec("INSERT INTO tasks (description, due, list_id) VALUES ('#{@description}', '#{@due}', #{@list_id})")
  end



end
