import Vue from 'vue';
import App from './App.vue';
import vuetify from './plugins/vuetify';
import router from './router';
import store from './store';


Vue.config.productionTip = false

// Event bus
export const EventBus = new Vue();

// Override matcher to support external links.
// This avoids the behavior where this application's domain name gets
// prepended to external links (like client app URLs that may have
// a unique domain name).
const match = router.matcher.match
router.matcher.match = (...args) => {
  let route = match.apply(router, args)
  if (!route.meta.external) {
    return route
  }
  return Object.freeze({ ...route, fullPath: route.path })
}

// Main vue instance
new Vue({
  vuetify,
  router,
  store,
  render: h => h(App),
}).$mount('#app')