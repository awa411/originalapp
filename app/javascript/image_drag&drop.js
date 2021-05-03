if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener('DOMContentLoaded', function(){
    const imageArea = document.getElementById('image-area');
    const imageList = document.getElementById("image-list");
    const inputList = document.getElementById("input-list");
    const newArticleImage = document.getElementById("article_image_-1");
    newArticleImage.setAttribute('class', 'focus_input');
    const dropText = document.getElementById('drop-text');
    if(imageList.childElementCount != 0){
      dropText.setAttribute('style', 'display: none;')
    };

    const createImageHTML = (blob) => {
      const imageElement = document.createElement('div');
      imageElement.setAttribute('id', 'image-element');
      imageElement.setAttribute('class', 'image-element');
      let imageElementNum = document.querySelectorAll('.image-element').length
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('id', 'blob-image');
      if (document.getElementsByClassName('article_image_input').length == 0 ) {
        blobImage.setAttribute('class', 'article_image_-1');
       } else {
        blobImage.setAttribute('class', `article_image_${imageElementNum - 1}`);
      }
      const inputHTML = document.createElement('input');
      inputHTML.setAttribute('id', `article_image_${imageElementNum}`);
      inputHTML.setAttribute('name', 'article[images][]');
      inputHTML.setAttribute('class', 'article_image_input')
      inputHTML.setAttribute('type', 'file');
      inputHTML.classList.add('focus_input');
      imageElement.appendChild(blobImage);
      inputList.appendChild(inputHTML)
      imageList.appendChild(imageElement);
      if (document.getElementsByClassName('article_image_input').length == 1 ) {
        document.getElementById(`article_image_-1`).setAttribute('style', 'visibility: hidden; color: rgba(0,0,0,0);');
        document.getElementById(`article_image_-1`).classList.remove('focus_input');
      } else {
        document.getElementById(`article_image_${imageElementNum - 1}`).setAttribute('style', 'visibility: hidden; color: rgba(0,0,0,0);');
        document.getElementById(`article_image_${imageElementNum - 1}`).classList.remove('focus_input');
      }

      inputHTML.addEventListener('change', (e) => {
        const file = e.target.files[0];
        const blob = window.URL.createObjectURL(file);
        createImageHTML(blob);
      });

      blobImage.addEventListener('mouseover', () => {
        blobImage.setAttribute('style', "opacity: 0.4;")
      });

      blobImage.addEventListener('mouseout', () => {
        blobImage.removeAttribute('style', "opacity: 0.4;")
      });

      blobImage.addEventListener('click', () => {
        const targetInput = document.getElementById(`${blobImage.className}`);
        targetInput.value = "";
        if (!(targetInput.id == 'article_image_-1')) {
          targetInput.remove();
        };
        blobImage.parentNode.setAttribute('style', 'display: none;')
        blobImage.remove();

        if (document.getElementsByClassName('article_image_input').length == 1 && document.getElementById('article_image_-1').value == "" ) {
          document.getElementById('article_image_-1').nextElementSibling.remove();
          document.getElementById('article_image_-1').removeAttribute('style', 'visibility: hidden;');
          document.getElementById('article_image_-1').setAttribute('class', 'focus_input');
          dropText.removeAttribute('style', 'display: none;');
        }
      });
     };



     
     const body = document.querySelector('body');
     
     body.addEventListener('dragover', (e) => {
       e.preventDefault();
       imageList.setAttribute('style', 'background-color: rgba(206, 207, 196, 0.4);')
      });

      imageList.addEventListener('dragover', (e) => {
        e.preventDefault();
        e.stopPropagation();
        imageList.setAttribute('style', 'background-color: rgba(206, 207, 196, 0.4); border: 3px solid lightblue;')
      });
      
      body.addEventListener('dragleave', (e) => {
        e.preventDefault();
        imageList.removeAttribute('style', 'background-color: rgba(206, 207, 196, 0.4);')
      });
      
      imageList.addEventListener('dragleave', (e) => {
        e.preventDefault();
        e.stopPropagation();
        imageList.removeAttribute('style', 'background-color: rgba(206, 207, 196, 0.4); border: 3px solid lightblue;')
      });

      imageList.addEventListener('drop', (e) => {
        e.preventDefault();
        imageList.removeAttribute('style', 'background-color: rgba(206, 207, 196, 0.4); border: 3px solid lightblue;')
        dropText.setAttribute('style', 'display: none;');
        const input = document.querySelector("input[class*='focus_input']");
        input.files = e.dataTransfer.files;
        console.log(input)
        const blob = window.URL.createObjectURL(input.files[0]);
        createImageHTML(blob);
      });

      newArticleImage.addEventListener('change', (e) => {
        dropText.setAttribute('style', 'display: none;');
        const file = e.target.files[0];
        const blob = window.URL.createObjectURL(file);
        createImageHTML(blob);
      });
  });
};