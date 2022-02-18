<template>
  <v-row align="center" justify="center">
    <v-col cols="12" sm="8" md="4">
      <v-card class="elevation-12">
        <v-toolbar color="primary" dark flat>
          <v-spacer />
          <v-toolbar-title>Sistema de Estoque de Alimentos - IFRN</v-toolbar-title>
          <v-spacer />
        </v-toolbar>
        <v-card-text>
          <v-form>
            <v-text-field label="Matrícula" v-model="usuario.matricula" prepend-icon="mdi-account-circle" type="text" autocomplete="off" />
            <v-text-field label="Senha" @keypress.enter="autenticarUsuario" v-model="usuario.senha" prepend-icon="mdi-lock-reset" type="password" autocomplete="off" />
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer />
          <v-btn color="primary" @click="autenticarUsuario">Entrar</v-btn>
          <v-spacer />
        </v-card-actions>
      </v-card>
    </v-col>
  </v-row>
</template>
<script>
import Usuario from "@/api/Usuario";

export default {
  name: "Login",
  components: {},
  data() {
    return {
      usuario: {
        matricula: "",
        senha: ""
      },
      novoUsuario: {
        matricula: ""
      }
    };
  },
  methods: {
    autenticarUsuario() {
      Usuario.autenticar(
        this.usuario,
        () => {
          this.$router.push("/home");
        },
        () => {
          alert("Falha ao realizar login");
          this.usuario.senha = "";
        }
      );
    }
  }
};
</script>
