<template>
  <v-data-table :headers="cabecalho" :items="categorias" :search="pesquisar" sort-by="nome" class="elevation-1">
    <template v-slot:top>
      <v-toolbar flat color="white">
        <v-toolbar-title>Categorias</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-text-field v-model="pesquisar" append-icon="mdi-magnify" label="Procurar" single-line hide-details class="mr-5"></v-text-field>
        <v-dialog v-model="modal" max-width="500px">
          <template v-slot:activator="{ on }">
            <v-btn color="primary" dark class="mb-2" v-on="on">Adicionar</v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="headline">Adicionar categoria</span>
            </v-card-title>

            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="12">
                    <v-text-field v-model="novaCategoria.nome" autocomplete="off" label="Categoria" @keypress.enter="salvar"></v-text-field>
                  </v-col>
                </v-row>
              </v-container>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="primary" text @click="cancelar">Cancelar</v-btn>
              <v-btn color="primary" text @click="salvar" :disabled="habilitarBotaoCadastro">Salvar</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-toolbar>
    </template>
    <template v-slot:item.acao="{ item }">
      <v-icon small color="blue" @click="editarItem(item)">
        mdi-pencil
      </v-icon>
      <v-icon small color="red" class="ml-1" @click="deletarItem(item)">
        mdi-trash-can
      </v-icon>
    </template>
  </v-data-table>
</template>

<script>
import Vue from "vue";
import Categoria from "@/api/Categoria";

export default {
  name: "Categorias",
  data: () => ({
    modal: false,
    pesquisar: "",
    edicao: false,
    cabecalho: [
      {
        text: "Nome",
        align: "left",
        value: "nome"
      },
      {
        text: "Ações",
        align: "right",
        value: "acao",
        sortable: false
      }
    ],
    categorias: [],
    novaCategoria: {
      nome: "",
      id: ""
    }
  }),
  created() {
    this.inicializar();
  },
  methods: {
    inicializar() {
      Vue.axios.get("categoria").then(response => {
        this.categorias = response.data;
      });
    },
    deletarItem(item) {
      const id = item.id;
      if (confirm(`Deseja deletar a categoria ${item.nome}?`)) {
        const id = item.id;
        Categoria.deletar(
          id,
          () => {
            alert("Categoria deletada com sucesso");
            this.inicializar();
          },
          () => {
            alert("Falha");
          }
        );
      }
    },
    editarItem(item) {
      this.edicao = true;
      this.novaCategoria.nome = item.nome;
      this.novaCategoria.id = Number(item.id);
      this.modal = true;
    },
    cancelar() {
      this.modal = false;
      this.edicao = false;
      this.novaCategoria.nome = "";
    },
    salvar() {
      if (this.edicao) {
        Categoria.atualizar(
          this.novaCategoria,
          () => {
            alert("Atualização realizada com sucesso");
            this.inicializar();
          },
          () => {
            alert("Falha ao atualizar categoria");
          }
        );
      } else {
        Categoria.cadastrar(
          this.novaCategoria,
          () => {
            alert("Cadastro realizado com sucesso");
            this.inicializar();
          },
          () => {
            alert("Falha ao cadastrar categoria");
          }
        );
      }
      this.cancelar();
    },
  },
  computed: {
    habilitarBotaoCadastro() {
      if (!this.novaCategoria.nome.length > 0) {
        return true;
      } else {
        return false;
      }
    }
  }
};
</script>
