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
        <div class="new_icon">NEW</div>
        <a href="${data.article_path}"><img class="article-image" src="${data.image}"></a>
        <a class="article-title" href="${data.article_path}">${data.article.title}</a>
        <div class="article-category">カテゴリー：<a href="${data.category_path}">${data.category_name}</a></div>
        <div class="article-nickname">筆者：<a href="${data.user_path}">${data.user.nickname}</a></div>
      </div>`
    const articles = document.getElementById("article-wrapper");
    articles.insertAdjacentHTML('afterbegin', html);
  }
});
