<template>
  <v-container fluid>
    <v-container>
      <v-expansion-panels multiple>
        <v-expansion-panel>
          <v-expansion-panel-header> Tx </v-expansion-panel-header>
          <v-expansion-panel-content>
            <v-row>
              <v-col md="8">
                <v-combobox
                  v-model="pub_select"
                  :items="pub_items"
                  label="Pub"
                  outlined
                  hint="Select from existing destinations or define a new one"
                  dense
                  small-chips
                  persistent-hint
                ></v-combobox>
              </v-col>
              <v-col md="4">
                <v-btn> Conn / Disc </v-btn>
              </v-col>
            </v-row>
            <v-row>
              <v-col md="10">
                <v-textarea
                  clearable
                  outlined
                  v-model="pub_msg"
                  name="aaaaaaa"
                  label="Tx"
                ></v-textarea>
              </v-col>
              <v-col md="2">
                <v-btn>
                  <v-icon fab @click="transmit(pub_select, pub_msg)">
                    mdi-send
                  </v-icon>
                </v-btn>
              </v-col>
            </v-row>
          </v-expansion-panel-content>
        </v-expansion-panel>
        <v-expansion-panel>
          <v-expansion-panel-header> Rx </v-expansion-panel-header>
          <v-expansion-panel-content>
            <v-row>
              <v-col md="8">
                <v-combobox
                  v-model="sub_select"
                  :items="sub_items"
                  label="Sub"
                  outlined
                  hint="Select from existing destinations or define a new one"
                  dense
                  small-chips
                  persistent-hint
                ></v-combobox>
              </v-col>
              <v-col md="4">
                <v-btn @click="subscribe(sub_select)"> Conn / Disc </v-btn>
              </v-col>
            </v-row>
            <v-row>
              <v-col md="10">
                <v-textarea
                  clearable
                  outlined
                  v-model="sub_msg"
                  name="aaaaaaa"
                  label="Rx"
                ></v-textarea>
              </v-col>
            </v-row>
          </v-expansion-panel-content>
        </v-expansion-panel>
        <v-expansion-panel>
          <v-expansion-panel-header> View </v-expansion-panel-header>
          <v-expansion-panel-content>
            <VuePlotly
              class="graph"
              :data="plot_data"
              :layout="plot_layout"
              :options="plot_options"
            />
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </v-container>
  </v-container>
</template>

<script>
import { EventBus } from "../main";
import { mapActions } from "vuex";
import VuePlotly from "@statnett/vue-plotly";

export default {
  name: "Messenger",
  components: {
    VuePlotly,
  },
  created() {
    EventBus.$on("stompMsg", (msg) => {
      this.onMsg(msg);
    });
  },
  data() {
    return {
      f1: "",
      pub_msg: "",
      sub_msg: "",
      pub_select: ["/topic/A.B.C"],
      pub_items: ["/topic/A.B.C", "/topic/A.B.D"],
      sub_select: ["/topic/A.B.C"],
      sub_items: ["/topic/A.B.C", "/topic/A.B.D"],
      count: 0,
      plot_data: [
        {
          x: [new Date()],
          y: [0],
          type: "scatter",
        },
      ],
      plot_layout: {
        title: "Message Count",
      },
      plot_options: {},
    };
  },
  methods: {
    ...mapActions("logger", ["log"]),
    transmit(dest, msg) {
      const sendEvent = {
        dest: dest,
        message: msg,
      };
      EventBus.$emit("stompSend", sendEvent);
    },
    subscribe(dest) {
      EventBus.$emit("stompSubscribe", dest);
    },
    onMsg(msg) {
      if (this.sub_msg == null) {
        this.sub_msg = "";
      }
      if (msg != undefined) {
        if (msg.dest == this.sub_select) {
          this.sub_msg += msg.message + "\n";
          this.count = this.count + 1;
          this.plot_data[0].x.push(new Date());
          this.plot_data[0].y.push(this.count);
        }
      }
    },
  },
};
</script>