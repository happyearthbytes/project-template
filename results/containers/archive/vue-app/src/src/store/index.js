import Vue from 'vue'
import Vuex from 'vuex'

import logger from './modules/logger'
import settings from './modules/settings'

// Load Vuex
Vue.use(Vuex)

export default new Vuex.Store({
    modules: {
        settings,
        logger,
    },
});