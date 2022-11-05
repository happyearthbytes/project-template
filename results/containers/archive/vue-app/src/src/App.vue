<template>
  <div id="app">
    <Stomp />
    <MsgProc />
    <Frame />
  </div>
</template>

<script>
import Stomp from "./components/Stomp";
import MsgProc from "./components/MsgProc";

import Frame from "./components/Frame.vue";

export default {
  name: "App",
  components: {
    Frame,
    Stomp,
    MsgProc,
  },
};
</script>

<style lang="sass">
*
  font-family: 'Trebuchet MS', sans-serif
</style>
