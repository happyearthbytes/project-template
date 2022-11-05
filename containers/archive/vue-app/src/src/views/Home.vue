<template>
  <v-container fluid>
    <v-container>
      <VuePlotly
        class="graph"
        :data="data"
        :layout="layout"
        :options="options"
      />
      <v-btn @click="addData()">Add</v-btn>
    </v-container>
  </v-container>
</template>

<script>
import VuePlotly from "@statnett/vue-plotly";

export default {
  name: "Home",
  components: {
    VuePlotly,
  },
  data() {
    return {
      count: 4,
      data: [
        {
          x: [1, 2, 3, 4],
          y: [0.4, 0.2, 0.6, 0.1],
          type: "scatter",
        },
      ],
      layout: {
        title: "Plot sample",
      },
      options: {},
    };
  },
  methods: {
    addData() {
      this.count = this.count + 1;
      this.data[0].x.push(this.count);
      this.data[0].y.push(Math.random());
    },
  },
};
</script>

<style>
.graph {
  height: 300px;
}
</style>