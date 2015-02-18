'use strict'


dependencies = [
  'ngAnimate',
  'ngCookies',
  'ngResource',
  'ngRoute',
  'ngSanitize',
  'ngTouch',
  'dewApp.filters',
  'dewApp.services',
  'dewApp.controllers',
  'dewApp.directives',
  'dewApp.common',
  'dewApp.routeConfig'
]

app = angular.module('dewApp', dependencies)

angular.module('dewApp.routeConfig', ['ngRoute'])
.config ($routeProvider) ->
  $routeProvider
  .when('/', {
      templateUrl: '/views/view.html'
    })
  .when('/users/create', {
      templateUrl: '/views/create.html'
    })
  .when('/users/edit/:firstName/:lastName', {
      templateUrl: '/views/update.html'
    })
  .when('/tasks/create', {
      templateUrl: '/views/create_task.html'
    })
  .when('/task/edit/:description', {
      templateUrl: '/views/update_task.html'
    })
  .otherwise({redirectTo: '/'})
.config ($locationProvider) ->
  $locationProvider.html5Mode({
    enabled: true,
    requireBase: false
  })

@commonModule = angular.module('dewApp.common', [])
@controllersModule = angular.module('dewApp.controllers', [])
@servicesModule = angular.module('dewApp.services', [])
@modelsModule = angular.module('dewApp.models', [])
@directivesModule = angular.module('dewApp.directives', [])
@filtersModule = angular.module('dewApp.filters', [])

