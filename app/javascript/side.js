if (location.pathname.match("article") && !(document.URL.match( /new/ )) && !(document.URL.match( /edit/ )) ) {
  window.addEventListener('load', function(){
    const side = document.getElementById("show-article-side")
    side.addEventListener('mouseover', function(){
      const categories = document.getElementById("show-categories")
      categories.setAttribute("style", "animation-name: fade-in;")
      categories.addEventListener('mouseout', function(){
        categories.removeAttribute("style", "animation-name: fade-in;")
      })
    });
  });
};