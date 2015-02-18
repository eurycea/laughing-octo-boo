class TaskCtrl

  constructor: (@$log, @TaskService) ->
    @$log.debug "constructing TaskController new"
    @tasks = []
    @error = null
    @getAllTasks()

  getAllTasks: () ->
    @$log.debug "getAllTasks()"

    @TaskService.listTasks()
    .then(
      (data) =>
        @$log.debug "Promise returned #{data.length} Tasks"
        @tasks = data
    ,
      (error) =>
        @$log.error "Unable to get Tasks: #{error}"
        @error = error
    )

controllersModule.controller('TaskCtrl', TaskCtrl)