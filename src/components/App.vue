<template>
  <div class="container">
    <!-- <header class="header">header</header> -->
    <div class="content">
      <div class="side">
        <search-form v-model="search" :default="defaultSearch" :cards="cards" :decks="decks"></search-form>
      </div>
      <div class="main">
        <card-list :search="search" :cards="cards" :decks="decks"></card-list>
      </div>
    </div>
    <!-- <footer class="footer">footer</footer> -->
  </div>
</template>

<script>
import SearchForm from './SearchForm'
import CardList from './CardList'

import cards from "../../data/cards.json"
import decks from "../../data/decks.json"


const DEFAULT_SEARCH = {
  format: {
    standard: true,
  },
  hero: "",
  mana: {
    usable: "",
    odd: false,
    even: false,
  },
  types: [
    "呪文", "ミニオン", "武器", "ヒーロー",
  ],
  rank: 1,
  decks: [
  ],

}

export default {
  components: {
     SearchForm,
     CardList,
  },
  data() {
    // カードを配列に
    const _cards = _.values(cards)

    // デッキリストを日本語名を追加
    _.each(decks, (deck) => {
      if(deck.cards_en) {
        deck.cards = _.map(deck.cards_en, (name_en) => {
          const card = _.find(cards, (card) => {
            return card.name_en == name_en
          })
          if(card) {
            return card.name
          } else {
            console.error("nothing " + name_en)
            return ""
          }
        })
      }
    })

    // カードがどのデッキに使われてるかを出す & ランク付け
    _.each(_cards, (card) => {
      const usedDecks = _.filter(decks, (deck) => {
        return _.includes(deck.cards, card.name)
      })
      card.decks = _.map(usedDecks, "name")

      card.rank = 0
      card.rankByHero = {}
      _.each(usedDecks, (deck) => {
        const rank = 5 - deck.tier
        // 全体のランクに加算
        card.rank += rank
        // ヒーローごとのランクに加算
        if(!card.rankByHero[deck.hero]) {
          card.rankByHero[deck.hero] = 0
        }
        card.rankByHero[deck.hero] += rank
      })
    })

    return {
      search: _.cloneDeep(DEFAULT_SEARCH),
      defaultSearch: DEFAULT_SEARCH,
      decks: decks,
      cards: _cards,
    }
  },



}

</script>

<style lang="scss" scoped>

.container {
  padding: 1%;
}

.header,
.footer {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 10px;
  background: #eee;
}

.content {
  display: flex;
  padding: 20px 0;
}

.main {
  flex: 1 0 auto;
  display: flex;
  // align-items: center;
  // justify-content: center;
  margin-left: 15px;
}

.side {
  display: flex;
  // align-items: center;
  justify-content: center;
  position: -webkit-sticky;
  position: sticky;
  top: 10px;
  min-width: 140px;
  height: 650px;
  color: #fff;
  background: #30b298;
  padding-top: 10px;
}

</style>

