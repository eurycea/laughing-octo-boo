class UpdateTaskCtrl
  
  constructor: (@$log, @$location, @$routeParams, @TaskService) ->
    @$log.debug("construcing UpdateTaskCtrl")
    @task = {}
    @findTask()
    
  updateTask: () ->
    @$log.debug("updateTask()")
    @task.complete = false
    @TaskService.updateTask(@$routeParams.description, @task)
    
  findTask: () ->
    description = @$routeParams.description
    @$log.debug("find Task route params: #{description}")
    
    @TaskService.listTasks()
    .then(
      (data) =>
        @$log.debug("promise returned #{data.length} tasks")
        @task = (data.filter (user) -> user.description is description)[0]
    ,
      (error) =>
        @$log.error("unable to get tasks: #{error}")
    )

controllersModule.controller('UpdateTaskCtrl', UpdateTaskCtrl)