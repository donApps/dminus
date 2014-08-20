// smooth scroll to anchor
$(function() {
  $('a[href*=#]:not([href=#])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html,body').animate({
          scrollTop: target.offset().top
        }, 1000);
        return false;
      }
    }
  });
});

// smoove
function close(a,b) {
    if(20 * Math.round(a/20) === 20 * Math.round(b/20)) return true;
}
$('.box-list>li, .fullrow .row>*').each( function() {
    if(close($(this).offset().left, $(this).parent().offset().left)) {
        $(this).data({move: '-100px,100px'});
    }
    else if(close($(this).offset().left + $(this).outerWidth(), $(this).parent().offset().left + $(this).parent().outerWidth())) {
        $(this).data({move: '100px,100px'});
    }
    else {
        $(this).data({moveY: '100px'});
    }
});
$('section, .box-list>li, .fullrow .row>*').smoove({offset: '10%'});


$(document).ready(function ($) {
    // delegate calls to data-toggle="lightbox"
    $(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
        event.preventDefault();
        return $(this).ekkoLightbox();
    });
});