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
    
    headerMenu.addEventListener('click', () => {
      if (headerMenuLi.style.display == 'none') {
        headerMenuLi.setAttribute('style', 'display: block;')
      } else {
        headerMenuLi.setAttribute('style', 'display: none;')
      }
    });
    
    document.addEventListener('click', (e) =>{
      if(!e.target.closest('#header-menu')) {
        if (headerMenuLi.style.display == 'block') {
          headerMenuLi.setAttribute('style', 'display: none;')
        }
      }
    })

  };
});