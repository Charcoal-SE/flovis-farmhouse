// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  $('.selectpicker').selectpicker({
    actionsBox: true
  });

  $('.stage-data').each(function (i, e) {
    $(e).text(JSON.stringify(JSON.parse($(e).text()), null, 4));
  });

  $('[name=stage]').on('change', function () {
    if ($(this).val()) {
      $('[name=ls]').attr('disabled', true).selectpicker('refresh');
    }
    else {
      $('[name=ls]').attr('disabled', false).selectpicker('refresh');
    }
  });

  $('[name=ls]').on('change', function () {
    if ($(this).val()) {
      $('[name=stage]').attr('disabled', true).selectpicker('refresh');
    }
    else {
      $('[name=stage]').attr('disabled', false).selectpicker('refresh');
    }
  });
});
