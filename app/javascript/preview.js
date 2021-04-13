document.addEventListener('DOMContentLoaded', function(){
  const imageList = document.getElementById("image-list");
  
  const createImageHTML = (blob) => {
    const imageElement = document.createElement('div');
    imageElement.setAttribute('id', 'image-element');
    const blobImage = document.createElement('img');
    blobImage.setAttribute('src', blob);
    blobImage.setAttribute('id', 'blob-image');
    imageElement.appendChild(blobImage);
    imageList.appendChild(imageElement);
  };
  
  const newArticleImage = document.getElementById("new-article_image");
  newArticleImage.addEventListener('change', function(e){
    const blobImage = document.getElementById('blob-image');
    if (blobImage){
      blobImage.parentNode.remove();
    }
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    createImageHTML(blob);
  });
});