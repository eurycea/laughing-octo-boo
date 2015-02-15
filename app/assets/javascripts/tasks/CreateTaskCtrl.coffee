
class CreateTaskCtrl
  
  constructor: (@$log, @$location, @TaskService) ->
    @$log.debug "constructing CreateTaskController"
    @task = {}
    
  createTask: () ->
    @$log.debug("createTask")
    @task.complete = false
    @TaskService.createTask(@task)
    .then(
      (data) => 
        @$log.debug ""
        @task = data
        @$location.path("/")
       ,
      (error) =>
         @$log.error "Unable to create Task: #{error}"
      )
    
controllersModule.controller('CreateTaskCtrl', CreateTaskCtrl) 