<template>
  <v-data-table :headers="cabecalho" :items="produtos" :search="pesquisar" sort-by="nome" class="elevation-1">
    <template v-slot:top>
      <v-toolbar flat color="white">
        <v-toolbar-title>Produtos</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-text-field v-model="pesquisar" append-icon="mdi-magnify" label="Procurar" single-line hide-details class="mr-5"></v-text-field>
        <v-dialog v-model="modal" max-width="500px">
          <template v-slot:activator="{ on }">
            <v-btn color="primary" dark class="mb-2" v-on="on">Adicionar</v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="headline">Adicionar produto</span>
            </v-card-title>

            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="12">
                    <v-text-field v-model="novoProduto.nome" label="Nome"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="12" md="6">
                    <v-select v-model="novoProduto.categoria_id" :items="categorias" item-text="nome" item-value="id" label="Categoria"></v-select>
                  </v-col>
                  <v-col cols="12" sm="12" md="6">
                    <v-select v-model="novoProduto.fornecedor_id" :items="fornecedores" item-text="nome_fantasia" item-value="id" label="Fornecedor"></v-select>
                  </v-col>
                  <v-col cols="12" sm="12" md="6">
                    <v-text-field v-model="novoProduto.estoque" label="Estoque" type="number"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="12" md="6">
                    <v-text-field v-model="novoProduto.validade" label="Validade" @keypress.enter="salvar"></v-text-field>
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
import Vue from "vue";
import Produto from "@/api/Produto";

export default {
  name: "Produtos",
  data: () => ({
    modal: false,
    edicao: false,
    pesquisar: "",
    cabecalho: [
      {
        text: "Nome",
        align: "left",
        value: "nome"
      },
      {
        text: "Categoria",
        align: "left",
        value: "categoria.nome"
      },
      {
        text: "Fornecedor",
        align: "left",
        value: "fornecedor.nome_fantasia"
      },
      {
        text: "Estoque",
        align: "left",
        value: "estoque"
      },
      {
        text: "Validade",
        align: "left",
        value: "validade"
      },
      {
        text: "Ações",
        align: "right",
        value: "acao",
        sortable: false
      }
    ],
    produtos: [],
    categorias: [],
    fornecedores: [],
    novoProduto: {
      nome: "",
      categoria_id: "",
      fornecedor_id: "",
      estoque: 0,
      validade: "",
      id: ""
    }
  }),
  created() {
    this.inicializar();
  },
  methods: {
    inicializar() {
      Vue.axios.get("produto?expand=categoria,fornecedor").then(response => {
        this.produtos = response.data;
      });
      Vue.axios.get("fornecedor").then(response => {
        this.fornecedores = response.data;
      });
      Vue.axios.get("categoria").then(response => {
        this.categorias = response.data;
      });
    },
    editarItem(item) {
      this.edicao = true;
      this.novoProduto.nome = item.nome;
      this.novoProduto.categoria_id = item.categoria_id;
      this.novoProduto.fornecedor_id = item.fornecedor_id;
      this.novoProduto.estoque = Number(item.estoque);
      this.novoProduto.validade = item.validade;
      this.novoProduto.id = item.id;
      this.modal = true;
    },
    deletarItem(item) {
      const id = item.id;
      if (confirm(`Deseja deletar o produto ${item.nome}?`)) {
        const id = item.id;
        Produto.deletar(
          id,
          () => {
            alert("Produto deletado com sucesso");
            this.inicializar();
          },
          () => {
            alert(
              "Este produto não pode ser deletado porque é referenciado em outra tabela"
            );
          }
        );
      }
    },
    cancelar() {
      this.edicao = false;
      this.novoProduto.nome = "";
      this.novoProduto.categoria_id = "";
      this.novoProduto.fornecedor_id = "";
      this.novoProduto.estoque = "";
      this.novoProduto.validade = "";
      this.modal = false;
    },
    salvar() {
      this.novoProduto.estoque = Number(this.novoProduto.estoque);
      if (this.edicao) {
        Produto.atualizar(
          this.novoProduto,
          () => {
            alert("Atualização realizada com sucesso");
            this.inicializar();
          },
          () => {
            alert("Falha ao atualizar produto");
          }
        );
      } else {
        Produto.cadastrar(
          this.novoProduto,
          () => {
            alert("Cadastro realizado com sucesso");
            this.inicializar();
          },
          () => {
            alert("Falha ao cadastrar produto");
          }
        );
      }
      this.cancelar();
    }
  }
};
</script>
