class TaskCtrl

  constructor: (@$log, @TaskService) ->
    @$log.debug "constructing TaskController new"
    @tasks = []
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
    )

controllersModule.controller('TaskCtrl', TaskCtrl)