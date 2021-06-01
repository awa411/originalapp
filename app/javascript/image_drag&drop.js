if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener('DOMContentLoaded', function(){
    const imageList = document.getElementById("image-list");
    const inputList = document.getElementById("input-list");
    const firstInput = document.getElementById("input_article_image_-1");
    const dropText = document.getElementById('drop-text');
    const body = document.querySelector('body');
    firstInput.setAttribute('class', 'focus_input');
    if(imageList.childElementCount > 1 ){
      dropText.setAttribute('style', 'display: none;')
    };

    const createImageHTML = (blob) => {
      const imageElement = document.createElement('div');
      imageElement.setAttribute('class', 'image-element');
      let imageElementNum = document.querySelectorAll('.image-element').length
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.setAttribute('class', 'blob-image');
      if (document.getElementsByClassName('article_image_input').length == 0 ) {
        blobImage.setAttribute('id', 'article_image_-1');
       } else {
        blobImage.setAttribute('id', `article_image_${imageElementNum - 1}`);
      }
      const inputHTML = document.createElement('input');
      inputHTML.setAttribute('id', `input_article_image_${imageElementNum}`);
      inputHTML.setAttribute('name', 'article[images][]');
      inputHTML.setAttribute('class', 'article_image_input')
      inputHTML.setAttribute('type', 'file');
      inputHTML.classList.add('focus_input');
      imageElement.appendChild(blobImage);
      inputList.appendChild(inputHTML)
      imageList.appendChild(imageElement);
      if (document.getElementsByClassName('article_image_input').length == 1 ) {
        firstInput.setAttribute('style', 'visibility: hidden; color: rgba(0,0,0,0);');
        firstInput.classList.remove('focus_input');
      } else {
        document.getElementById(`input_article_image_${imageElementNum - 1}`).setAttribute('style', 'visibility: hidden; color: rgba(0,0,0,0);');
        document.getElementById(`input_article_image_${imageElementNum - 1}`).classList.remove('focus_input');
      }

      // inputHTML.addEventListener('change', (e) => {
      //   const file = e.target.files[0];
      //   const blob = window.URL.createObjectURL(file);
      //   createImageHTML(blob);
      // });

      blobImage.addEventListener('mouseover', () => {
        blobImage.setAttribute('style', "opacity: 0.4;")
      });

      blobImage.addEventListener('mouseout', () => {
        blobImage.removeAttribute('style', "opacity: 0.4;")
      });

      blobImage.addEventListener('click', (e) => {
        const targetInput = document.getElementById(`input_${blobImage.id}`);
        console.log(targetInput.id)
        targetInput.value = "";
        if (!(targetInput.id == 'input_article_image_-1')) {
          targetInput.remove();
        };
        blobImage.parentNode.setAttribute('style', 'display: none;')
        blobImage.remove();

        if (document.getElementsByClassName('article_image_input').length == 1 && firstInput.value == "" ) {
          firstInput.nextElementSibling.remove();
          firstInput.removeAttribute('style', 'visibility: hidden;');
          firstInput.setAttribute('class', 'focus_input');
          dropText.removeAttribute('style', 'display: none;');
        }
      });
     };

    body.addEventListener('dragover', (e) => {
      e.preventDefault();
      imageList.setAttribute('style', 'background-color: rgba(206, 207, 196, 0.4); border: 3px solid lightblue;')
    });
    
    body.addEventListener('dragleave', (e) => {
      e.preventDefault();
      imageList.removeAttribute('style', 'background-color: rgba(206, 207, 196, 0.4); border: 3px solid lightblue;')
    });

    body.addEventListener('drop', (e) => {
      e.preventDefault();
      imageList.removeAttribute('style', 'background-color: rgba(206, 207, 196, 0.4); border: 3px solid lightblue;')
      dropText.setAttribute('style', 'display: none;');
      const input = document.querySelector(".focus_input");
      input.files = e.dataTransfer.files;
      const blob = window.URL.createObjectURL(input.files[0]);
      createImageHTML(blob);
    });
  });
};