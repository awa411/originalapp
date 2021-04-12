import consumer from "./consumer"

consumer.subscriptions.create("ArticleChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html =`
    <div class="article-content">
    <a href="/articles/30"><img class="article-image" src="http://localhost:3000/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBJdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--1df9ef9412c8f4fc367f04ceb80252ce77588dd8/bgBNxcCjPXZP8PjIf6MnhoO9ZGbyuUhD0iAlRcP4.jpeg"></a>
    <a class="article-title" href="/articles/30">test</a>
    <div class="article-category">カテゴリー：<a href="/articles/search?q%5Bcategory_id_eq=1">グルメ</a></div>
    <div class="article-nickname">筆者：<a href="/users/3">test3</a></div>
  </div>`;

    const articles = document.getElementById("article-wrapper");
    articles.insertAdjacentHTML('afterbegin', html);
  }
});
