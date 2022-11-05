<template>
  <v-menu
    v-model="menu"
    :close-on-content-click="false"
    offset-y
    transition="slide-y-transition"
  >
    <template v-slot:activator="{ on, attrs }">
      <v-btn tile depressed v-bind="attrs" v-on="on">
        <v-icon small left>mdi-form-select</v-icon> menu
        <v-icon>mdi-menu-down</v-icon>
      </v-btn>
    </template>

    <v-card>
      <v-list dense>
        <!-- Level-1 -->
        <v-template
          v-for="menu_item in menu_items"
          v-bind:key="menu_item.item.id"
        >
          <!-- Level-1-Group -->
          <v-list-group
            v-if="menu_item.sub"
            v-bind:key="menu_item.item.id"
            :prepend-icon="menu_item.item.icon"
          >
            <template v-slot:activator>
              <v-list-item-content>
                <v-list-item-title>
                  {{ menu_item.item.title }}
                </v-list-item-title>
              </v-list-item-content>
            </template>
            <!-- Level-2 -->
            <v-template
              v-for="sub_item in menu_item.sub"
              v-bind:key="sub_item.item.id"
            >
              <!-- Level-2-group -->
              <v-list-group v-if="sub_item.sub" sub-group dense>
                <template v-slot:activator>
                  <v-list-item-content>
                    <v-list-item-title>{{
                      sub_item.item.title
                    }}</v-list-item-title>
                  </v-list-item-content>
                  <v-list-item-action>
                    <v-icon>{{ sub_item.item.icon }}</v-icon>
                  </v-list-item-action>
                </template>
                <v-list-item
                  v-for="last_item in sub_item.sub"
                  v-bind:key="last_item.item.id"
                  @click="menu = false"
                  link
                >
                  <!-- Level-3-item -->
                  <v-list-item-title>
                    {{ last_item.item.title }}
                  </v-list-item-title>
                  <v-list-item-icon>
                    <v-icon> {{ last_item.item.icon }}</v-icon>
                  </v-list-item-icon>
                </v-list-item>
              </v-list-group>
              <!-- Level-2-item -->
              <v-list-item
                v-else
                v-bind:key="sub_item.item.id"
                @click="menu = false"
                link
              >
                <v-list-item-content>
                  <v-list-item-title>{{
                    sub_item.item.title
                  }}</v-list-item-title>
                </v-list-item-content>
                <v-list-item-action>
                  <v-icon>{{ sub_item.item.icon }}</v-icon>
                </v-list-item-action>
              </v-list-item>
            </v-template>
          </v-list-group>
          <!-- Level-1-Item -->
          <v-list-item
            v-else
            v-bind:key="menu_item.item.id"
            @click="menu = false"
            link
          >
            <v-list-item-content>
              <v-list-item-title>{{ menu_item.item.title }}</v-list-item-title>
            </v-list-item-content>
            <v-list-item-action>
              <v-icon>{{ menu_item.item.icon }}</v-icon>
            </v-list-item-action>
          </v-list-item>
        </v-template>
      </v-list>
    </v-card>
  </v-menu>
</template>


<script>
export default {
  name: "SubMenu",
  props: {
    menu_data: {
      type: Object,
    },
  },
  data: () => ({
    menu: false,
    menu_items: [
      {
        item: { id: "1", title: "File", icon: "mdi-file" },
        sub: [
          {
            item: {
              id: "1.1",
              title: "New",
              icon: "mdi-file-plus",
              function: null,
            },
            sub: null,
          },
          {
            item: { id: "1.2", title: "Open", icon: "mdi-folder-open" },
            sub: [
              {
                item: {
                  id: "1.2.1",
                  title: "Open Configuration",
                  icon: "mdi-folder-cog",
                  function: null,
                },
                sub: null,
              },
              {
                item: {
                  id: "1.2.2",
                  title: "Open Data",
                  icon: "mdi-folder-table",
                  function: null,
                },
                sub: null,
              },
            ],
          },
          {
            item: { id: "1.3", title: "Save", icon: "mdi-content-save" },
            sub: [
              {
                item: {
                  id: "1.3.1",
                  title: "Save Configuration",
                  icon: "mdi-content-save-cog",
                  function: null,
                },
                sub: null,
              },
              {
                item: {
                  id: "1.3.2",
                  title: "Save Data",
                  icon: "mdi-content-save-move",
                  function: null,
                },
                sub: null,
              },
            ],
          },
        ],
      },
      {
        item: { id: "2", title: "View", icon: "mdi-eye" },
        sub: [
          {
            item: { id: "2.1", title: "Appearance", icon: "mdi-eye-plus" },
            sub: null,
          },
          {
            item: { id: "2.2", title: "Layout", icon: "mdi-view-dashboard" },
            sub: null,
          },
          {
            item: { id: "2.3", title: "Output", icon: "mdi-eye-plus" },
            sub: null,
          },
        ],
      },
      {
        item: {
          id: "3",
          title: "Help",
          icon: "mdi-help-circle",
          function: null,
        },
        sub: null,
      },
    ],
  }),
};
</script>


<style scoped lang="sass">
</style>
