<template>
  <!-- footer -->
  <v-footer padless absolute>
    <!-- TODO Add expand option for full log-->
    <v-card dark flat tile width="100%">
      <v-expansion-panels focusable>
        <v-expansion-panel>
          <v-expansion-panel-header>
            <span class="mx-4">Log</span>
            <v-divider vertical> </v-divider>
            <span class="mx-4"> {{ log_highlight }} </span>
            <!-- <v-icon>mdi-book-open-variant</v-icon> -->
          </v-expansion-panel-header>
          <v-expansion-panel-content>
            <template>
              <v-card>
                <!-- tabs -->
                <v-tabs v-model="tab">
                  <v-tabs-slider></v-tabs-slider>
                  <v-tab v-for="item in tab_items" :key="item">
                    {{ item }}
                  </v-tab>
                </v-tabs>

                <!-- Log content -->
                <v-tabs-items v-model="tab">
                  <v-tab-item v-for="item in tab_items" :key="item">
                    <v-card class="overflow-y-auto" scrollable height="300">
                      <v-card-text>
                        <div
                          :class="color_map[message.status]"
                          v-for="message in getLog(item)"
                          v-bind:key="message.id"
                        >
                          {{ message.date }} - {{ message.id }} -
                          {{ message.msg }}
                        </div>
                      </v-card-text>
                    </v-card>
                    <v-divider></v-divider>
                    <v-text-field
                      v-model="manual_log"
                      :append-icon="'mdi-send'"
                      @click:append="
                        log({
                          msg: manual_log,
                          category: item,
                          status: 'manual',
                        })
                      "
                      label="Manual log"
                      placeholder="Log Message"
                      clearable
                      solo
                      hide-details="auto"
                    ></v-text-field>
                  </v-tab-item>
                </v-tabs-items>
              </v-card>
            </template>
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </v-card>
  </v-footer>
</template>


<script>
import { mapActions, mapGetters, mapState } from "vuex";
import { LogCategories } from "../constants";

export default {
  name: "Footer",
  data() {
    return {
      tab: null,
      manual_log: null,
      tab_items: LogCategories,
      color_map: {
        info: "",
        warning: "orange",
        error: "red",
        debug: "blue",
        manual: "green",
      },
    };
  },
  computed: {
    ...mapGetters("logger", ["getLog"]),
    ...mapState("logger", ["log_highlight"]),
  },
  methods: {
    ...mapActions("logger", ["log"]),
  },
};
</script>

<style scoped lang="sass">
</style>
