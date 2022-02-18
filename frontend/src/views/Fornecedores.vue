<template>
  <v-data-table :headers="cabecalho" :items="fornecedores" :search="pesquisar" sort-by="nome" class="elevation-1">
    <template v-slot:top>
      <v-toolbar flat color="white">
        <v-toolbar-title>Fornecedores</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-text-field v-model="pesquisar" append-icon="mdi-magnify" label="Procurar" single-line hide-details class="mr-5"></v-text-field>
        <v-dialog v-model="modal" max-width="500px">
          <template v-slot:activator="{ on }">
            <v-btn color="primary" dark class="mb-2" v-on="on">Adicionar</v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="headline">Adicionar fornecedor</span>
            </v-card-title>

            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="6">
                    <v-text-field v-model="novoFornecedor.nome_fantasia" label="Nome fantasia"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6">
                    <v-text-field v-model="novoFornecedor.razao_social" label="Razão social"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6">
                    <v-text-field v-model="novoFornecedor.cnpj" v-mask="['##.###.###/####-##']" label="CNPJ"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6">
                    <v-text-field v-model="novoFornecedor.email" label="Email"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6">
                    <v-text-field v-model="novoFornecedor.telefone" v-mask="['(##) ####-####']" label="Telefone"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6">
                    <v-text-field v-model="novoFornecedor.celular" v-mask="['(##) #####-####']" label="Celular" @keypress.enter="salvar"></v-text-field>
                  </v-col>
                </v-row>
              </v-container>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="primary" text @click="cancelar">Cancelar</v-btn>
              <v-btn color="primary" text @click="salvar">Salvar</v-btn>
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
import { mask } from "vue-the-mask";
import Vue from "vue";
import Fornecedor from "@/api/Fornecedor";

export default {
  name: "Fornecedores",
  directives: { mask },
  data: () => ({
    modal: false,
    pesquisar: "",
    edicao: false,
    cabecalho: [
      {
        text: "Nome fantasia",
        align: "left",
        value: "nome_fantasia"
      },
      {
        text: "Razão social",
        align: "left",
        value: "razao_social"
      },
      {
        text: "CNPJ",
        align: "left",
        value: "cnpj"
      },
      {
        text: "Email",
        align: "left",
        value: "email"
      },
      {
        text: "Telefone",
        align: "left",
        value: "telefone"
      },
      {
        text: "Ações",
        align: "right",
        value: "acao",
        sortable: false
      }
    ],
    fornecedores: [],
    novoFornecedor: {
      nome_fantasia: "",
      razao_social: "",
      cnpj: "",
      email: "",
      telefone: "",
      celular: "",
      id: ""
    }
  }),
  created() {
    this.inicializar();
  },
  methods: {
    inicializar() {
      Vue.axios.get("fornecedor").then(response => {
        this.fornecedores = response.data;
      });
    },
    editarItem(item) {
      this.edicao = true;
      this.novoFornecedor.nome_fantasia = item.nome_fantasia;
      this.novoFornecedor.razao_social = item.razao_social;
      this.novoFornecedor.cnpj = item.cnpj;
      this.novoFornecedor.email = item.email;
      this.novoFornecedor.telefone = item.telefone;
      this.novoFornecedor.celular = item.celular;
      this.novoFornecedor.id = Number(item.id);
      this.modal = true;
    },
    deletarItem(item) {
      console.log(item);

      const id = item.id;
      if (confirm(`Deseja deletar o fornecedor ${item.nome_fantasia}?`)) {
        const id = item.id;
        Fornecedor.deletar(
          id,
          () => {
            alert("Fornecedor deletado com sucesso");
            this.inicializar();
          },
          () => {
            alert("Falha");
          }
        );
      }
    },
    cancelar() {
      this.edicao = false;
      this.novoFornecedor.nome_fantasia = "";
      this.novoFornecedor.razao_social = "";
      this.novoFornecedor.cnpj = "";
      this.novoFornecedor.email = "";
      this.novoFornecedor.telefone = "";
      this.novoFornecedor.celular = "";
      this.novoFornecedor.id = "";
      this.modal = false;
    },
    salvar() {
      if (this.edicao) {
        Fornecedor.atualizar(
          this.novoFornecedor,
          () => {
            alert("Atualização realizada com sucesso");
            this.inicializar();
          },
          () => {
            alert("Falha ao atualizar fornecedor");
          }
        );
      } else {
        Fornecedor.cadastrar(
          this.novoFornecedor,
          () => {
            alert("Cadastro realizado com sucesso");
            this.inicializar();
          },
          () => {
            alert("Falha ao cadastrar fornecedor");
          }
        );
      }

      this.cancelar();
    }
  }
};
</script>
