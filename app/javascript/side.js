window.addEventListener('load', function(){
  if(document.getElementById('show-article-side')){    
    const side = document.getElementById("show-article-side")
    const categories = document.getElementById("show-categories")
    side.addEventListener('mouseover', function(){
      categories.setAttribute("style", "animation-name: fade-in;")
      categories.style.animationFillMode = "forwards";
    });
    categories.addEventListener('mouseout', function(){
      categories.setAttribute("style", "animation-name: fade-Out;")
      categories.style.animationFillMode = "forwards";
    })
  }
});