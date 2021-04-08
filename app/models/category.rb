class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: 'グルメ' },
    { id: 2, name: '生活' },
    { id: 3, name: '育児' },
    { id: 4, name: '健康' },
    { id: 5, name: '旅行' },
    { id: 6, name: '美容' },
    { id: 7, name: 'ファッション' },
    { id: 8, name: '教育' },
    { id: 9, name: '読書' },
    { id: 10, name: 'デザイン' },
    { id: 11, name: 'ビジネス' },
    { id: 12, name: 'IT' },
    { id: 13, name: '漫画' },
    { id: 14, name: '芸能' },
    { id: 15, name: 'テレビ・映画' },
    { id: 16, name: 'ゲーム' },
    { id: 17, name: 'スポーツ' }
  ]

  include ActiveHash::Associations
  has_many :articles

end