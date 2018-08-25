import Vue from 'vue'
import VueLodash from 'vue-lodash'
import App from './components/App'

const options = { name: 'lodash' }
Vue.use(VueLodash, options)

new Vue({
    el: '#app', // アプリをマウントする要素
    components: { App }, // Appというコンポーネントを使うよ、という宣言
    template: '<app/>', // el(今回は#app)の中に表示する内容
})