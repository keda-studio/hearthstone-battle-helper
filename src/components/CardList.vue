<template>
  <div class="card-list">
    <table>
      <tr>
        <th width="99px">ヒーロー</th>
        <th width="67px">タイプ</th>
        <th witdh="275px">名前</th>
        <!-- <th witdh="35px">ランク</th> -->
        <th witdh="35px">マナ</th>
        <th witdh="35px">攻撃</th>
        <th witdh="35px">体力</th>
        <th witdh="99px">種族</th>
        <th>詳細</th>
      </tr>
      <tr v-for="card in filterCards">
        <td>{{card.hero}}</td>
        <td>{{card.type}}</td>
        <td>{{card.name}}</td>
        <!-- <td>{{search.hero && card.rankByRank ? card.rankByRank[search.hero] : card.rank}}</td> -->
        <td>{{card.mana}}</td>
        <td>{{card.atk}}</td>
        <td>{{card.def}}</td>
        <td>{{card.kind}}</td>
        <td>{{card.detail}}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import cards from "../../data/cards.json"

export default {
  props: [
    'search',
    'cards',
    'decks',
  ],
  data() {
    return {
    }
  },
  computed: {
    filterCards() {
      const search = this.search
      // 絞り込み
      let resultCards = this.cards.filter((card) => {
        let result = true;
        // フォーマット
        if(search.format.standard) {
          result = result && card.format == "スタンダード"
        }
        // ヒーロー
        if(search.hero) {
          result = result && ( card.hero == search.hero || card.hero == "中立" )
        }
        // マナ
        if(search.mana.usable) {
          result = result && ( card.mana <= search.mana.usable)
        }
        if(search.mana.odd) {
          result = result && ( card.mana % 2 == 1)
        }
        if(search.mana.even) {
          result = result && ( card.mana % 2 == 0)
        }
        // タイプ
        if(_.size(search.types) > 0) {
          result = result && _.includes(search.types, card.type)
        }

        // ランク
        if(search.rank) {
          if(search.hero) {
            result = result && card.rankByHero && card.rankByHero[search.hero] >= search.rank
          } else {
            result = result && card.rank >= search.rank
          }
        }
        // デッキ
        if(_.size(search.decks) > 0) {
          result = result && _.size(_.intersection(search.decks, card.decks)) > 0
        }

        return result
      })
      resultCards = _.sortBy(resultCards, ["mana"])
      return resultCards
    },
  },
}
</script>

<style lang="scss" scoped>
table {
  *border-collapse: collapse; /* IE7 and lower */
  border-spacing: 0;
}
th:first-child {
  -moz-border-radius: 6px 0 0 0;
  -webkit-border-radius: 6px 0 0 0;
  border-radius: 6px 0 0 0;
}
th:last-child {
  -moz-border-radius: 0 6px 0 0;
  -webkit-border-radius: 0 6px 0 0;
  border-radius: 0 6px 0 0;
}
tr:hover {
  background: #fbf8e9 !important;
  -o-transition: all 0.1s ease-in-out;
  -webkit-transition: all 0.1s ease-in-out;
  -moz-transition: all 0.1s ease-in-out;
  -ms-transition: all 0.1s ease-in-out;
  transition: all 0.1s ease-in-out;
}
body tr:nth-child(even) {
  background: #f5f5f5;
  box-shadow: 0 1px 0 rgba(255,255,255,.8) inset;
}
table,td,th {
  border-collapse: collapse;
  border:1px solid #333;
}
</style>


