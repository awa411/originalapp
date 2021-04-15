if (location.pathname.match( "article" )) {
  window.addEventListener('load', function(){
    $('.slick01').slick({
      centerMode: true,
      centerPadding: '30%',
      dots: true,
      dotsClass: 'slick-dots2',
      focusOnSelect: true,
    });
  });
};