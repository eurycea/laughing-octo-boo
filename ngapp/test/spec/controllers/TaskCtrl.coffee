
describe 'Controller: TaskCtrl', () ->
   
    beforeEach ->
      module 'myApp'
    
    beforeEach ->
      inject ($controller, TaskService) ->
        @mockTaskService = TaskService
        
        spyOn(@mockTaskService, 'listTasks').and.callFake () ->
          []
        spyOn( @mockTaskService, 'createTask').and.callFake (task) ->
          task
        spyOn(@mockTaskService, 'updateTask').and.callFake (description, task) ->
          task.description = description
          return task
          
        @TaskCtrl = $controller 'TaskCtrl',{TaskService:TaskService}
        
    it 'should have no items to start', () ->
      expect(@TaskCtrl.tasks.length).toBe(0)

    it 'should have compiling tests', () ->
      expect(true).toEqual(true)