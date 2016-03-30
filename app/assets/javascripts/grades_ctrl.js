(function(){
  
  angular.module("app").controller('gradesCtrl', function($scope){
    $scope.gradeLink = function(assignment, student){
      window.document.location = "/assignments/" + assignment + "?student_id=" + student;
    };
  });
}())