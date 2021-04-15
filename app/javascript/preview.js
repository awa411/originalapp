if (document.URL.match( /new/ )) {
  document.addEventListener('DOMContentLoaded', function(){
    const imageList = document.getElementById("image-list");
    const inputList = document.getElementById("input-list");
    
    const createImageHTML = (blob) => {
      const imageElement = document.createElement('div');
      imageElement.setAttribute('id', 'image-element');
      imageElement.setAttribute('class', 'image-element');
      let imageElementNum = document.querySelectorAll('.image-element').length
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('id', 'blob-image');
      blobImage.setAttribute('class', `article_image_${imageElementNum - 1}`);
      const inputHTML = document.createElement('input');
      inputHTML.setAttribute('id', `article_image_${imageElementNum}`);
      inputHTML.setAttribute('name', 'article[images][]');
      inputHTML.setAttribute('class', 'article_image_input')
      inputHTML.setAttribute('type', 'file');
      imageElement.appendChild(blobImage);
      inputList.appendChild(inputHTML)
      imageList.appendChild(imageElement);
      document.getElementById(`article_image_${imageElementNum - 1}`).setAttribute('style', 'visibility: hidden;');

      inputHTML.addEventListener('change', (e) => {
        const file = e.target.files[0];
        const blob = window.URL.createObjectURL(file);
        createImageHTML(blob);
      });
      
      blobImage.addEventListener('click', () => {
      const targetInput = document.getElementById(`${blobImage.className}`);
      targetInput.value = "";
      if (!(targetInput.id == "article_image_-1")) {
        targetInput.remove();
      };
      blobImage.parentNode.remove();
      if (document.getElementsByClassName('article_image_input').length == 1 & document.getElementById("article_image_-1").value == "" ) {
        document.getElementById("article_image_-1").nextElementSibling.remove();
        document.getElementById("article_image_-1").removeAttribute('style', 'visibility: hidden;');

      }
      });
    };
    
    const newArticleImage = document.getElementById("article_image_-1");
    newArticleImage.addEventListener('change', function(e) {
      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
  });
}