// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require angular
//= require bootstrap/bootstrap-tooltip
//= require bootstrap-datepicker
//= require bootstrap-timepicker

$(document).ready(function () {
  $('[data-toggle="popover"]').popover();
  $('[data-toggle="tooltip"]').tooltip()
  $('.date-picker').datepicker({
  	format: "m-d-yyyy",
  	startDate: "0d",
 	weekStart: 1,
 	forceParse: true,
 	orientation: "top"
  });
  $('.time-picker').timepicker({
    minuteStep: 5,
    showInputs: false,
    disableFocus: true,
    defaultTime: false
  });
})

