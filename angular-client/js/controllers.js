var hummingbird = angular.module('Hummingbird', ['ng-token-auth']);

hummingbird.config(function($authProvider) {
  $authProvider.configure({
            apiUrl: 'http://localhost:3000' //your api's url
          });
});

hummingbird.controller('mainCtrl', function ($scope, $http, $auth) {


  //OAUTH SIGN IN
  $scope.handleBtnClick = function() {
    $auth.authenticate('google')
    .then(function(resp) {
      alert('something successful happened')
    })
    .catch(function(resp) {
        // handle errors
        alert('something terrible happened')
      });
  };

  //OAUTH SIGN OUT
  $scope.handleSignOutBtnClick = function() {
      $auth.signOut()
        .then(function(resp) {
          // handle success response
        })
        .catch(function(resp) {
          // handle error response
        });
    };

});
