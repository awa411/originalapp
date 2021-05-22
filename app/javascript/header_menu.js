document.addEventListener('DOMContentLoaded', function(){
  if (document.getElementById('header-menu-li')){
    const headerMenu = document.getElementById('header-menu');
    const headerMenuLi = document.querySelector('#header-menu-li')
  
    headerMenu.addEventListener('mouseover', () => {
      headerMenu.setAttribute('style', 'color: gray;')
      headerMenuLi.style.animationName = "SlideIn";
      headerMenuLi.style.animationFillMode = "backwards";
      headerMenuLi.style.display = "block";
    });

    headerMenu.addEventListener('mouseout', () => {
      headerMenu.removeAttribute('style', 'color: gray;')
      headerMenuLi.style.animationName = "SlideOut";
      headerMenuLi.style.animationFillMode = "forwards";
    });
  };
});