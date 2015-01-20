class Task

  attr_reader(:description, :due, :list_id, :id)

  define_method(:==) do |another_task|
    self.description() == another_task.description() && self.list_id() == another_task.list_id() && self.due() == another_task.due() && self.id() == another_task.id()
  end

  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @list_id = attributes.fetch(:list_id)
    @due = attributes.fetch(:due)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch('description')
      list_id = task.fetch('list_id').to_i()
      due = task.fetch('due')
      id = task.fetch('id').to_i()
      tasks.push(Task.new({:description => description, :due => due, :list_id => list_id, :id => id}))
    end
    tasks
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO tasks (description, due, list_id) VALUES ('#{@description}', '#{@due}', #{@list_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:delete) do
    DB.exec("DELETE FROM tasks WHERE id = #{self.id()};")
  end

  define_singleton_method(:find) do |id|
    Task.all().each() do |task|
      if task.id() == id
        return task
      end
    end
  end



end
