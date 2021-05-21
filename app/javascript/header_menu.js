document.addEventListener('DOMContentLoaded', function(){
  if (document.getElementsByClassName('header-menu')){
    const headerMenu = document.getElementById('header-menu');
    const headerMenuLi = document.querySelector('#header-menu li')
    headerMenu.addEventListener('mouseover', () => {
      headerMenu.setAttribute('style', 'color: gray;')
    });

    headerMenu.addEventListener('mouseout', () => {
      headerMenu.removeAttribute('style', 'color: gray;')
    });
    
    document.addEventListener('click', (e) =>{
      if(e.target.closest('#header-menu')) {
        if (headerMenuLi.style.display == 'none') {
          headerMenuLi.style.display = "block";
        } else {
          headerMenuLi.style.display = "none";
        }      
      }
      if(!e.target.closest('#header-menu')) {
        if (headerMenuLi.style.display == 'block') {
          headerMenuLi.style.display = "none";
        }
      }
    });

  };
});