<template>
  <div class="frame">
    <v-app>
      <NavBar />

      <!-- main view -->
      <v-main>
        <!-- router view -->
        <router-view />
      </v-main>

      <Footer />
    </v-app>
  </div>
</template>

<script>
import NavBar from "./NavBar.vue";
import Footer from "./Footer.vue";

export default {
  name: "Frame",
  components: {
    NavBar,
    Footer,
  },
  data() {
    return {
      deleteme: null,
    };
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="sass">
a
  color: #42b983
</style>