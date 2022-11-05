import {
  LogCategories
} from '../../constants';

let message_map = Object.assign({}, ...LogCategories.map((x) => ({ [x]: [] })));
let count_map = Object.assign({}, ...LogCategories.map((x) => ({ [x]: 1 })));
const default_category = "general";
const default_status = "info";

const state = {
  logger: new Map(),
  //messages: { "general": [], "debug": [], "amq": [] },
  messages: message_map,
  msg_count: count_map,
  max_messages: 2000,
  log_highlight: "",
  log_highlight_level: default_status,
};

const mutations = {
  ADD_LOG(state, msgData) {
      var d = new Date();
      var datestring = d.getDate() + "/" + (d.getMonth() + 1) + "/" +
          d.getFullYear() + " " + d.getHours() + ":" + d.getMinutes() + ":" + (d.getSeconds() + 1);

      // Set defaults
      if (!("category" in msgData)) {
          msgData["category"] = default_category
      }
      if (!("status" in msgData)) {
          msgData["status"] = default_status
      }

      // Set the log highlight
      if (msgData.status == "warning" || msgData.status == "error") {
          if (msgData.status == "error") {
              state.log_highlight_level = msgData.status
              state.log_highlight = msgData.msg
          }
          else if (state.log_highlight_level != "error") {
              state.log_highlight_level = msgData.status
              state.log_highlight = msgData.msg
          }
      }

      // Add message
      state.messages[msgData.category].push({
          "date": datestring, "msg": msgData.msg,
          "id": state.msg_count[msgData.category],
          "status": msgData.status
      });

      // Roll over max messages
      state.msg_count[msgData.category] = state.msg_count[msgData.category] + 1;
      if (state.msg_count[msgData.category] > state.max_messages) {
          state.messages[msgData.category].shift()
      }
  },
  CLEAR_LOG(state) {
      state.messages["general"] = [];
  },
};

const actions = {
  log({ commit }, msgData) {
      commit('ADD_LOG', msgData);
  },
  clear({ commit }) {
      commit('CLEAR_LOG');
  },
};

const getters = {
  getLogger: state => {
      return state.logger;
  },
  getLog: (state) => (logCategory) => {
      return state.messages[logCategory]
  },
};

const namespaced = true;

export default {
  namespaced,
  state,
  getters,
  mutations,
  actions
}