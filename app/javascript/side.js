window.addEventListener('load', function(){
  const side = document.getElementById("show-article-side")
  side.addEventListener('mouseover', function(){
    const categories = document.getElementById("show-categories")
    //categories.setAttribute("style", "visibility: visible;")
    categories.setAttribute("style", "animation-name: fade-in;")
    categories.addEventListener('mouseout', function(){
      //categories.setAttribute("style", "visibility: hidden;")
      categories.removeAttribute("style", "animation-name: fade-in;")
    })
  });
});