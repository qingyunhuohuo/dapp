import Vue from 'vue'
import App from './App.vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import router from './router'
import VueResource from 'vue-resource'

import Web3 from 'web3'

Vue.prototype.$web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));

Vue.use(VueResource)
Vue.use(ElementUI)

Vue.use(ElementUI);

Vue.config.productionTip = false

new Vue({
  render: h => h(App),
  router,
}).$mount('#app')
