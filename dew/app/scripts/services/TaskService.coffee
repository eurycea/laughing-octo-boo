class TaskService
  @headers = {'Accept':'application/json', 'Content-Type':'application/json'}
  @defaultConfig = {headers: @headers}

  constructor: (@$log, @$http, @$q) ->
    @$log.debug("constructing TaskService")

  listTasks: () ->
    @$log.debug("listTasks()")
    deferred = @$q.defer()

    @$http.get("http://localhost:9000/tasks")
    .success((data, status, headers) =>
      @$log.info("successfully listed tasks - status #{status}")
      deferred.resolve(data)
    )
    .error( (data, status, headers) =>
      @$log.error("Failed to list tasks - status #{status}")
      deferred.reject(data)
    )
    deferred.promise

  createTask: (task) ->
    @$log.debug("createTask #{angular.toJson(task, true)}")
    deferred = @$q.defer()

    @$http.post('http://localhost:9000/task', task)
    .success((data, status, headers) =>
      @$log.info("successfully created task - status #{status}")
      deferred.resolve(data)
    )
    .error( (data, status, headers) =>
      @$log.error("Failed to create task - status #{status}")
      deffered.reject(data)
    )
    deferred.promise

  updateTask: (description, task) ->
    @$log.debug("updateTask #{angular.toJson(task, true)} with description: #{description}")
    deferred = @$q.defer()

    @$http.put("localhost:9000/task/#{description}", task)
    .success((data, status, headers) =>
      @$log.info("Successfully updated task - status #{status}")
      deferred.resolve(data)
    )
    .error((data, status, headers) =>
      @$log.error("Failed to update task - status #{status}")
      deferred.reject(data)
    )
    deferred.promise

servicesModule.service("TaskService", TaskService)
