
import Vue from 'vue'
import Router from 'vue-router'

import About from './views/About.vue'
import Help from './views/Help.vue'
import Home from './views/Home.vue'
import Messenger from './views/Messenger.vue'
import Preferences from './views/Preferences.vue'
import Status from './views/Status.vue'

Vue.use(Router)

// Configure the vue router instance
// Each route loads the view associated with the URL path suffix
export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/about',
      name: 'about',
      component: About
    },
    {
      path: '/help',
      name: 'help',
      component: Help
    },
    {
      path: '/preferences',
      name: 'preferences',
      component: Preferences
    },
    {
      path: '/status',
      name: 'status',
      component: Status
    },
    {
      path: '/messenger',
      name: 'messenger',
      component: Messenger
    },
  ]
})