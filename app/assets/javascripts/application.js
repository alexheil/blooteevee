//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var flashTimeout = function() {

  setTimeout(function() {
    $('.flash_js').fadeOut();
  }, 5000);

};

$(document).ready(flashTimeout);
$(document).on('turbolinks:load', flashTimeout);


var getFilename = function() {

  $('input[type="file"]').change(function(e){
    var fileName = e.target.files[0].name;
    $('.file-name').text(fileName);
    $('.file-name').addClass('padding-top');
  });

};

$(document).ready(getFilename);
$(document).on('turbolinks:load', getFilename);