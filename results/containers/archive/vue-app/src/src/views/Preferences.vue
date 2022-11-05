<template>
  <v-container fluid>
    <v-container>
      <v-expansion-panels>
        <v-expansion-panel>
          <v-expansion-panel-header> View </v-expansion-panel-header>
          <v-expansion-panel-content>
            <v-slider
              v-model="slide_value"
              step="10"
              thumb-label
              ticks
            ></v-slider>
            <v-radio-group v-model="radioGroup">
              <v-radio
                v-for="n in 3"
                :key="n"
                :label="'The Group'"
                :value="n"
              ></v-radio>
            </v-radio-group>
          </v-expansion-panel-content>
        </v-expansion-panel>
        <v-expansion-panel>
          <v-expansion-panel-header> Defaults </v-expansion-panel-header>
          <v-expansion-panel-content>
            <v-checkbox
              hide-details
              v-model="checkbox"
              :label="'One...'"
            ></v-checkbox>
            <v-checkbox
              hide-details
              v-model="checkbox"
              :label="'Two...'"
            ></v-checkbox>
            <v-checkbox
              hide-details
              v-model="checkbox"
              :label="'Three'"
            ></v-checkbox>
          </v-expansion-panel-content>
        </v-expansion-panel>
        <v-expansion-panel>
          <v-expansion-panel-header> Advanced </v-expansion-panel-header>
          <v-expansion-panel-content>
            <v-switch v-model="switch_model" :label="'Switch'"></v-switch>
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </v-container>
  </v-container>
</template>

<script>
export default {
  name: "Preferences",
  data() {
    return {
      slide_value: 0,
      checkbox: false,
      radioGroup: 1,
      switch_model: true,
    };
  },
};
</script>