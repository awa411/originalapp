if (document.URL.match( /edit/ ) ) {
  document.addEventListener('DOMContentLoaded', function(){
    const imageList = document.getElementById("image-list");
    let count = 0;
    let imagePaths = [];
    gon.images_path.forEach(function(path){
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', path);
      blobImage.setAttribute('id', `exists-blob-image_${count}`);
      blobImage.setAttribute('class', 'exists_blob_image');
      blobImage.addEventListener('click', () => {
        //const jsonPath = JSON.stringify(path);
        imagePaths.push(path);
        blobImage.remove();
      });
      blobImage.addEventListener('mouseover', () => {
        blobImage.setAttribute('style', "opacity: 0.4;")
      });

      blobImage.addEventListener('mouseout', () => {
        blobImage.removeAttribute('style', "opacity: 0.4;")
      });
      imageList.appendChild(blobImage);
      count = count + 1
    });
    $('#edit-article-form').on('submit', function(e) {
      e.preventDefault();
      const formData = new FormData($(this).get(0));
      imagePaths.forEach(function(imagePath){
        formData.append('imagePaths[]', imagePath );
      });
      $.ajax({
        url:         '/articles/' + gon.article_id,
        type:        "PATCH",
        data:        formData,
        // dataType:    'json',
        contentType: false,
        processData: false,
      });
    });
  });  
};
