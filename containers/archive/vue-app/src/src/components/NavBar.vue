<template>
  <!-- The toolbar -->
  <nav>
    <v-card flat tile>
      <v-app-bar dense>
        <v-app-bar-nav-icon @click.stop="drawer = !drawer">
        </v-app-bar-nav-icon>

        <!-- Home Icon -->
        <v-divider vertical></v-divider>
        <v-btn tile icon to="/" class="hidden-sm-and-down">
          <v-icon>mdi-home</v-icon>
        </v-btn>

        <!-- Menu -->
        <v-divider vertical></v-divider>
        <SubMenu />
        <v-divider vertical></v-divider>

        <!-- Page Name -->
        <v-btn text tile> {{ $route.name }} </v-btn>

        <v-spacer></v-spacer>

        <v-divider vertical> </v-divider>
        <!-- Status -->
        <v-tooltip bottom>
          <template v-slot:activator="{ on, attrs }">
            <v-btn tile icon to="/status" v-bind="attrs" v-on="on">
              <v-icon color="green darken-1">mdi-circle-slice-8</v-icon>
            </v-btn>
          </template>
          <span>Status</span>
        </v-tooltip>
        <v-divider vertical></v-divider>

        <!-- Prefrences -->
        <v-menu offset-y transition="slide-y-transition">
          <template v-slot:activator="{ on, attrs }">
            <v-btn icon v-bind="attrs" v-on="on">
              <v-icon>mdi-dots-vertical</v-icon>
            </v-btn>
          </template>
          <v-list>
            <v-list-item-group v-model="group" color="primary">
              <v-list-item
                v-for="(item, index) in preference_items"
                :key="index"
                :to="item.link"
                router
                exact
              >
                <v-list-item-icon>
                  <v-icon>{{ item.icon }}</v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                  <v-list-item-title>{{ item.text }}</v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list-item-group>
          </v-list>
        </v-menu>
      </v-app-bar>
    </v-card>

    <!-- Navigation -->
    <v-navigation-drawer
      v-model="drawer"
      absolute
      temporary
      disable-resize-watcher
    >
      <v-list nav dense>
        <v-list-item-group v-model="group" color="primary">
          <v-list-item
            v-for="(item, index) in getDrawerItems()"
            :key="index"
            :to="item.link"
            router
            exact
          >
            <v-list-item-icon>
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>{{ item.text }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
  </nav>
</template>


<script>
import SubMenu from "./SubMenu.vue";

export default {
  name: "NavBar",
  components: {
    SubMenu,
  },
  props: {
    msg: String,
  },
  data() {
    return {
      drawer: null,
      tab: null,
      dialog: null,
      file_menu: { name: "DEF" },
      preference_items: [
        { icon: "mdi-information", text: "About", link: "/about" },
        { icon: "mdi-cog", text: "Preferences", link: "/preferences" },
        { icon: "mdi-help-circle", text: "Help", link: "/help" },
      ],
    };
  },
  methods: {
    getDrawerItems() {
      var drawerItems = [
        { icon: "mdi-home", text: "Home", link: "/" },
        { icon: "mdi-message-text", text: "Messenger", link: "/messenger" },
        { icon: "mdi-information", text: "About", link: "/about" },
        { icon: "mdi-cog", text: "Preferences", link: "/preferences" },
        { icon: "mdi-circle-slice-8", text: "Status", link: "/status" },
      ];
      return drawerItems;
    },
  },
};
</script>


<style scoped lang="sass">
</style>
