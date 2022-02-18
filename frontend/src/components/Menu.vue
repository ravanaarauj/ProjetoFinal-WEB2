<template>
  <v-app-bar app color="primary" dark>
    <div class="d-flex align-center">
      <h1 class="font-weight-medium shrink mr-5" disabled>SEA</h1>
    </div>
    <div class="d-flex align-center" v-if="usuarioTipo !== 'admin'">
      <v-btn text small to="/home">
        <v-icon small>mdi-home</v-icon>
        <span class="ml-2">Página inicial</span>
      </v-btn>
      <v-divider vertical></v-divider>
      <v-btn text small to="/categorias" v-if="usuarioTipo === 'Nutricionista'">
        <v-icon small>mdi-menu</v-icon>
        <span class="ml-2">Categorias</span>
      </v-btn>
      <v-divider vertical v-if="usuarioTipo === 'Nutricionista'"></v-divider>
      <v-btn text small to="/fornecedores" v-if="usuarioTipo === 'Nutricionista'">
        <v-icon small>mdi-account-group</v-icon>
        <span class="ml-2">Fornecedores</span>
      </v-btn>
      <v-divider vertical v-if="usuarioTipo === 'Nutricionista'"></v-divider>
      <v-btn text small to="/produtos" v-if="usuarioTipo === 'Nutricionista'">
        <v-icon small>mdi-alpha-p-circle-outline</v-icon>
        <span class="ml-2">Produtos</span>
      </v-btn>
      <v-divider vertical v-if="usuarioTipo !== 'admin'"></v-divider>
      <v-btn text small to="/pedidos" v-if="usuarioTipo !== 'admin'">
        <v-icon small>mdi-cart-arrow-down</v-icon>
        <span class="ml-2">Pedidos</span>
      </v-btn>
    </div>
    <div class="d-flex align-center" v-else>
      <v-btn text small to="/home">
        <v-icon small>mdi-home</v-icon>
        <span class="ml-2">Página inicial</span>
      </v-btn>
    </div>

    <v-spacer></v-spacer>

    <v-btn text small @click="logout">
      <v-icon small>mdi-reply</v-icon>
      <span class="ml-2">Sair</span>
    </v-btn>
  </v-app-bar>
</template>
<script>
export default {
  name: "Menu",
  components: {},
  data() {
    return {
      usuarioTipo: localStorage.usuarioTipo
    };
  },
  methods: {
    logout() {
      localStorage.clear();
      this.$router.push("/");
    }
  },
  computed: {
    rotaAtual() {
      return this.$router.currentRoute.name;
    }
  }
};
</script>
