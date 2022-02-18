<template>
  <v-data-table :headers="cabecalho" :items="pedidos" :search="pesquisar" class="elevation-1">
    <template v-slot:top>
      <v-toolbar flat color="white">
        <v-toolbar-title>Pedidos</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-text-field v-model="pesquisar" append-icon="mdi-magnify" label="Procurar" single-line hide-details class="mr-5"></v-text-field>
        <v-btn color="primary" dark class="mb-2 ml-3" @click="abrirModal">Adicionar</v-btn>
        <v-dialog v-model="modal" max-width="500px">
          <v-card>
            <v-card-title>
              <span class="headline">Adicionar pedido</span>
            </v-card-title>

            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="12" md="6">
                    <v-autocomplete label="Produtos" v-model="novoPedido.produto_id" :items="produtos" item-text="nome" item-value="id"></v-autocomplete>
                  </v-col>
                  <v-col cols="12" sm="12" md="6">
                    <v-text-field v-model="novoPedido.quantidade" autocomplete="off" label="Quantidade" type="number" @keypress.enter="salvar"></v-text-field>
                  </v-col>
                </v-row>
              </v-container>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="primary" text @click="cancelar">Cancelar</v-btn>
              <v-btn color="primary" text @click="salvar" :disabled="Number(novoPedido.quantidade) > prodSelecionado[0].estoque">Salvar</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-toolbar>
    </template>
    <template v-slot:item.acao="{ item }">
      <v-icon small color="red" class="ml-1" @click="deletarItem(item)" :disabled="tipoAtual">
        mdi-trash-can
      </v-icon>
    </template>
  </v-data-table>
</template>

<script>
import Vue from "vue";
import Pedido from "@/api/Pedido";
import Produto from "@/api/Produto";

export default {
  name: "Pedidos",
  data: () => ({
    modal: false,
    pesquisar: "",
    cabecalho: [
      {
        text: "Data",
        align: "left",
        value: "data",
        sortable: false
      },
      {
        text: "Quantidade",
        align: "left",
        value: "quantidade",
        sortable: false
      },
      {
        text: "Produto",
        align: "left",
        value: "produto.nome",
        sortable: false
      },
      {
        text: "Usuário",
        align: "right",
        value: "usuario.nome",
        sortable: false
      },
      {
        text: "Ações",
        align: "right",
        value: "acao",
        sortable: false
      }
    ],
    pedidos: [],
    produtos: [],
    novoPedido: {
      data: new Date().toLocaleDateString(),
      usuario_id: localStorage.usuarioID,
      quantidade: 1,
      produto_id: ""
    }
  }),
  created() {
    this.inicializar();
  },
  methods: {
    inicializar() {
      Vue.axios.get("pedido?expand=produto,usuario").then(response => {
        this.pedidos = response.data;
      });
      Vue.axios.get("produto").then(response => {
        this.produtos = response.data.filter(prod => prod.estoque > 0);
      });
    },
    editarItem(item) {
      this.modal = true;
    },
    deletarItem(item) {
      const id = item.id;
      if (confirm(`Deseja deletar este pedido?`)) {
        Pedido.deletar(
          id,
          () => {
            alert("Pedido deletado com sucesso");
            this.inicializar();
          },
          () => {
            alert("Falha ao deletar pedido");
          }
        );
      }
    },
    cancelar() {
      this.modal = false;
    },
    salvar() {
      this.novoPedido.quantidade = Number(this.novoPedido.quantidade);
      this.novoPedido.usuario_id = Number(this.novoPedido.usuario_id);

      if (this.prodSelecionado[0].estoque >= this.novoPedido.quantidade) {
        Pedido.cadastrar(
          this.novoPedido,
          () => {
            Vue.axios
              .get(`produto/${this.novoPedido.produto_id}`)
              .then(response => {
                const produtoID = Number(this.novoPedido.produto_id);
                const novaQtdEstoque =
                  Number(response.data.estoque) - this.novoPedido.quantidade;
                const novoProduto = {
                  id: produtoID,
                  estoque: novaQtdEstoque
                };
                Produto.atualizar(novoProduto);
              });
            alert("Pedido realizado com sucesso");
            this.inicializar();
          },
          () => {
            alert("Falha ao cadastrar pedido");
          }
        );
        this.cancelar();
      }
    },
    abrirModal() {
      this.modal = true;
    }
  },
  computed: {
    tipoAtual() {
      if (localStorage.usuarioTipo !== "Nutricionista") {
        return true;
      } else {
        return false;
      }
    },
    prodSelecionado() {
      if (this.novoPedido.produto_id == "") {
        return [{ estoque: 1 }];
      } else {
        return this.produtos.filter(
          prod => prod.id === this.novoPedido.produto_id
        );
      }
    }
  }
};
</script>
