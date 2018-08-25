decks = []
const HERO_EN_JA = [
  [ "druid", "ドルイド" ],
  [ "hunter", "ハンター" ],
  [ "mage", "メイジ" ],
  [ "paladin", "パラディン" ],
  [ "priest", "プリースト" ],
  [ "rogue", "ローグ" ],
  [ "shaman", "シャーマン" ],
  [ "warlock", "ウォーロック" ],
  [ "warrior", "ウォリアー" ],
]

$(".tier-dropdown-headers").each(function(index, elem) {
  elem = $(elem)
  // デッキ名
  const name = elem.find(".hs-snapshot-deck-btn .titles").text()
  // ヒーロー
  const icon = elem.find(".class-icon-div")
  let hero = null
  HERO_EN_JA.forEach(function(arr) {
    if(icon.hasClass(arr[0])) {
      hero = arr[1]
    }
  })
  // tier
  const tier = elem.parent().attr('id').match(/^collapseTier(\d)$/)[1];

  // cards

  console.log(name)
  console.log(hero)
  console.log(tier)
})

