<template>
  <div class="search-form">
    <button @click="clear">クリア</button><br>
    <br>

    フォーマット<br>
    スタンのみ:<input type="checkbox" v-model="value.format.standard"><br>
    <br>

    ヒーロー<br>
    <select v-model="value.hero">
      <option value="">未選択</option>
      <option>メイジ</option>
      <option>ハンター</option>
      <option>パラディン</option>
      <option>ウォリアー</option>
      <option>ドルイド</option>
      <option>ウォーロック</option>
      <option>シャーマン</option>
      <option>プリースト</option>
      <option>ローグ</option>
    </select><br>
    <br>

    マナ<br>
    利用可能:<select v-model="value.mana.usable">
      <option value="">全て</option>
      <option v-for="n in 10">{{n}}</option>
    </select><br>
    偶数のみ:<input type="checkbox" v-model="value.mana.even"><br>
    奇数のみ:<input type="checkbox" v-model="value.mana.odd"><br>
    <br>

    タイプ<br>
    <select v-model="value.types" multiple>
      <option>呪文</option>
      <option>ミニオン</option>
      <option>武器</option>
      <option>ヒーロー</option>
    </select><br>
    <br>

    使用数: <select v-model="value.rank">
      <option v-for="n in 6" :value="n-1">{{n-1}}以上</option>
    </select><br>
    <br>

    デッキタイプ<br>
    <select v-model="value.decks" multiple class="select-decks">
      <option v-for="deck in heroDecks" :value="deck.name">{{deck.name}}(T{{deck.tier}})</option>
    </select><br>
    <br>


  </div>
</template>

<script>
export default {
  props: [
    'value',
    'default',
    'cards',
    'decks'
  ],
  data() {
    return {
    }
  },
  computed: {
    heroDecks() {
      return _.filter(this.decks, (deck) => {
        return deck.hero == this.value.hero
      })
    },
  },
  methods: {
    clear() {
      this.value = _.assignWith(this.value, this.default)

    },
  },
}
</script>

<style lang="scss" scoped>
select[multiple] {
  width: 100%;
  &.select-decks {
    height: 120px;
  }
}
</style>