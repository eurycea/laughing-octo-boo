
describe 'Controller: TaskCtrl', () ->
  #http://entwicklertagebuch.com/blog/2013/10/how-to-handle-angularjs-promises-in-jasmine-unit-tests/
  DEFAULT_TASK = ()->
    {description:"test task", complete:false}

  getTaskCtrl =  (controller, taskService) ->
    controller 'TaskCtrl', {TaskService:taskService}

  getMockTaskService = (TaskService, deferredList) ->
    mockTaskService = TaskService
    spyOn(mockTaskService, 'listTasks').and.returnValue(deferredList.promise);
    return mockTaskService

  beforeEach ->
    module 'dewApp'
  beforeEach ->
    inject ($rootScope, _$q_, $controller, TaskService) ->
      @$rootScope = $rootScope
      @deferredList = _$q_.defer()
      @mockTaskService = getMockTaskService(TaskService, @deferredList)
      @TaskCtrl = getTaskCtrl($controller, TaskService)

  it 'should have compiling tests', () ->
    expect(true).toEqual(true)

  it 'should get a list of tasks from the service', () ->
    @deferredList.resolve([DEFAULT_TASK()])
    @$rootScope.$apply()
    expect(@mockTaskService.listTasks).toHaveBeenCalled()
    expect(@TaskCtrl.tasks.length).toBe(1)
    expect(@TaskCtrl.error).toBeNull()

  it 'should handle TaskService errors', () ->
    @deferredList.reject("test error")
    @$rootScope.$apply()
    expect(@mockTaskService.listTasks).toHaveBeenCalled()
    expect(@TaskCtrl.tasks.length).toBe(0)
    expect(@TaskCtrl.error).not.toBeNull()
