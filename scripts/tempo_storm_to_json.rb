#! /Users/shindo_ryohei/.rbenv/shims/ruby

# 実行例
# $ cd scripts
# $ ruby tempo_storm_to_json.rb https://tempostorm.com/hearthstone/meta-snapshot/standard/2018-08-12 > ../data/decks.json

require 'active_support'
require 'active_support/core_ext'
require 'nokogiri'
require 'watir-webdriver'
require 'open-uri'
require 'pp'
require "json"

HERO_EN_JA = {
  "druid" => "ドルイド",
  "hunter" => "ハンター",
  "mage" => "メイジ",
  "paladin" => "パラディン",
  "priest" => "プリースト",
  "rogue" => "ローグ",
  "shaman" => "シャーマン",
  "warlock" => "ウォーロック",
  "warrior" => "ウォリアー",
}

url = ARGV[0]

browser = Watir::Browser.new(:chrome)
browser.goto(url)

Watir::Wait.until { browser.button(:css, ".btn-tier-collapse").present? }

# browser.buttons(:css, ".btn-tier-collapse").each_with_index do |button, index|
#   button.click
#   Watir::Wait.until { browser.div(:css, "#tier#{index+1} .tier-dropdown-headers").present? }
# end

decks = []
4.times do |i|
  tier = i+1
  tier_elem = browser.div(:css, "#tier#{tier}")

  # 開く
  tier_elem.button(:css, ".btn-tier-collapse").click
  Watir::Wait.until {
    tier_elem.div(:css, "#collapseTier#{tier}").attribute_value('aria-expanded') == "true"
  }

  # 各デッキごとに
  tier_elem.divs(:css, ".mobile-deck-header").each do |deck|
    # デッキ名
    titles = deck.div(:css, ".titles").text.match(/^(\d+)\. (.+)$/)
    deck_rank = titles[1]
    deck_name = titles[2]
    # ヒーロー名
    hero_name_en = deck.div(:css, ".class-icon-div").attribute_value('class').split[1]
    hero_name = HERO_EN_JA[hero_name_en]
    # URL
    url = deck.a(:css, ".big-view-deck-link").href

    decks << {
      rank: deck_rank,
      name: deck_name,
      hero: hero_name,
      hero_en: hero_name_en,
      tier: tier,
      url: url,
    }
  end
end

decks.each do |deck|
  browser.goto(deck[:url])
  Watir::Wait.until { browser.div(:css, ".side-content .db-deck-card-name").present? }
  deck[:cards_en] = browser.divs(:css, ".side-content .db-deck-card-name").map(&:text)
end

json =JSON.pretty_generate(decks)
puts json

browser.quit

