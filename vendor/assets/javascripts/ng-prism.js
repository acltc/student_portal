angular.module('ngPrism', []).
    directive('ngPrism', ['$compile', function($compile) {
        return {
            restrict: 'A',
            transclude: true,
            scope: {
              source: '@'
            },
            link: function(scope, element, attrs, controller, transclude) {
                scope.$watch('source', function(v) {
                  element.find("code").html(v);

                  Prism.highlightElement(element.find("code")[0]);
                });

                transclude(function(clone) {
                  if (clone.html() !== undefined) {
                    element.find("code").html(clone.html());
                    $compile(element.contents())(scope.$parent);
                  }
                });
            },
            template: "<code></code>"
        };
    }]);





/**
 * Usage 
 * 
 * <ng-prism class="language-css">
 *      body {
 *         color: red; 
 *      }
 * </ng-prism>
 * 
 * the files prismjs and prism css must be included in HTML, use class "language-XXX" to specify language
 * */
// angular.module('ngPrism', []).
//     directive('ngPrism',['$interpolate', function ($interpolate) {
//             "use strict";
//             return {
//                 restrict: 'E',
//                 template: '<pre><code ng-transclude></code></pre>',
//                 replace: true,
//                 transclude: true,
//                 link: function (scope, elm) {
//                     var tmp = $interpolate(elm.find('code').text())(scope);
//                     elm.find('code').html(Prism.highlightElement(tmp).value);
//                 }
//             };
//         }]);



/*
*
* ng-prism v0.0.1
*
* (c) 2013-2014 Sercan Eraslan http://sercaneraslan.com
* License: MIT
*
*/
// angular.module('ngPrism', []).
//     directive('prism', [function() {
//         return {
//             restrict: 'A',
//             link: function ($scope, element, attrs) {
//                 element.ready(function() {
//                     Prism.highlightElement(element[0]);
//                 });
//             }
//         }
//     }]
// );