import {
  MsgDestinations
} from '../../constants';

const getDefaultState = () => {
  return {
      // Application configuration
      config: {
          host: window.location.hostname,
          port: 61614,
          msgDests: MsgDestinations,
          // Enable engineering
          showEngineering: false,
      },
  }
};

const state = getDefaultState();

const mutations = {
  SET_CONFIG(state, config) {
      state.config = config;
  },
  RESET_STATE(state) {
      Object.assign(state, getDefaultState());
  }
};

const actions = {
  applySettings({ commit }, settings) {
      commit('SET_CONFIG', settings);
  },
  resetSettingsState({ commit }) {
      commit('RESET_STATE');
  }
};

const getters = {
  allSettings: state => state.config
};

const namespaced = true;

export default {
  namespaced,
  state,
  mutations,
  actions,
  getters
}