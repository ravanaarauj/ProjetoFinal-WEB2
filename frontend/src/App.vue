<template>

  <v-app>
    <Menu v-if="this.$route.name !== 'login'"></Menu>
    <v-content>
      <v-container fluid :class="this.$route.name === 'login' ? 'fill-height' : ''">
        <router-view></router-view>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
import Menu from "@/components/Menu.vue";

export default {
  name: "App",

  components: {
    Menu
  },

  data: () => ({})
};
</script>
