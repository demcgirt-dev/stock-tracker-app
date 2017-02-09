/*global $*/
/*global show_spinner*/
/*global hide_spinner*/

var init_friend_lookup;

init_friend_lookup = function() {
  $('#friend-lookup-form').on('ajax:before', function(event, data, status) {
    show_spinner();  
  });
  
  $('#friend-lookup-form').on('ajax:after', function(event, data, status) {
    hide_spinner();  
  });
  
  $('#friend-lookup-form').on('ajax:success', function(event, data, status) {
    $('#friend-lookup').replaceWith(data);
    init_friend_lookup();
  });
  
  $('#friend-lookup-form').on('ajax:error', function(event, xhr, status, error) {
    $('#friend-lookup-results').replaceWith(' ');
    $('#friend-lookup-errors').replaceWith('person was not found.');
    hide_spinner();
  });
}

$(document).ready(function () {
  init_friend_lookup();
  console.log("Javascript is working!");
  alert("Jquery is still working.");
})