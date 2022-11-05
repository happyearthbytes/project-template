<template>
  <v-container fluid>
    <v-container>
      <v-card>
        <v-data-table :headers="headers" :items="items" :items-per-page="10">
        </v-data-table>
      </v-card>
    </v-container>
  </v-container>
</template>

<script>
export default {
  name: "About",
  data() {
    return {
      headers: [
        { text: "Name", value: "name" },
        { text: "Value", value: "value" },
        { text: "Description", value: "description" },
      ],
      items: [
        {
          name: "UI Version",
          value: "1.1",
          description: "The UI Version Number",
        },
        {
          name: "SW Version",
          value: "1.3",
          description: "The SW Version Number",
        },
        {
          name: "Repo",
          value: "the_link",
          description: "The link to the repository",
        },
        {
          name: "Jenkins",
          value: "the_link",
          description: "The link to the repository",
        },
      ],
    };
  },
};
</script>