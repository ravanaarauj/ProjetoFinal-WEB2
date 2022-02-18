<template>
  <div>
    <v-data-table :headers="cabecalho" :items="usuarios" :search="procurar" class="elevation-1" v-if="tipo === 'admin'">
      <template v-slot:top>
        <v-toolbar flat color="white">
          <v-toolbar-title>Painel de administrador</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-text-field v-model="procurar" append-icon="mdi-magnify" label="Procurar" single-line hide-details class="mr-5"></v-text-field>
          <v-btn color="primary" dark class="mb-2 ml-3" @click="abrirModal">Adicionar</v-btn>
          <v-dialog v-model="modal" max-width="700px">
            <v-card>
              <v-card-title>
                <span class="headline">Adicionar usuário</span>
              </v-card-title>

              <v-card-text>
                <v-container>
                  <v-row>
                    <v-col cols="12" sm="12" md="6">
                      <v-text-field v-model="novoUsuario.nome" label="Nome" autocomplete="off"></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="12" md="6">
                      <v-text-field v-model="novoUsuario.matricula" label="Matrícula" autocomplete="off"></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="12" md="6">
                      <v-text-field v-model="novoUsuario.email" label="Email" autocomplete="off"></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="12" md="6">
                      <v-select v-model="novoUsuario.tipo" :items="categorias" label="Tipo"></v-select>
                    </v-col>
                    <v-col cols="12" sm="12" md="6">
                      <v-text-field v-model="novoUsuario.senha" label="Senha" type="password" autocomplete="off"></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="12" md="6">
                      <v-text-field v-model="novoUsuario.senha2" label="Confirmar senha" type="password" autocomplete="off" @keypress.enter="salvar"></v-text-field>
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
        <v-icon small color="red" class="mr-1" @click="deletarUsuario(item)">
          mdi-trash-can
        </v-icon>
      </template>
    </v-data-table>
    <div v-if="tipo !== 'admin'">
      <v-row>
        <v-col>
          <v-card max-width="300">
            <v-card-text>
              <div class="title text-center font-weight-light mb-1">Categorias</div>
              <div class="subtitle-1 text-center font-weight-bold primary--text">{{qtdCategorias}}</div>
            </v-card-text>
          </v-card>
        </v-col>
        <v-col>
          <v-card max-width="300">
            <v-card-text>
              <div class="title text-center font-weight-light mb-1">Fornecedores</div>
              <div class="subtitle-1 text-center font-weight-bold primary--text">{{qtdFornecedores}}</div>
            </v-card-text>
          </v-card>
        </v-col>
        <v-col>
          <v-card max-width="300">
            <v-card-text>
              <div class="title text-center font-weight-light mb-1">Produtos</div>
              <div class="subtitle-1 text-center font-weight-bold primary--text">{{qtdProdutos}}</div>
            </v-card-text>
          </v-card>
        </v-col>
        <v-col>
          <v-card max-width="300">
            <v-card-text>
              <div class="title text-center font-weight-light mb-1">Pedidos</div>
              <div class="subtitle-1 text-center font-weight-bold primary--text">{{qtdPedidos}}</div>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </div>
  </div>
</template>

<script>
import Vue from "vue";
import Usuario from "@/api/Usuario";

export default {
  name: "Home",
  components: {},
  data() {
    return {
      qtdCategorias: 0,
      qtdFornecedores: 0,
      qtdProdutos: 0,
      qtdPedidos: 0,
      nome: localStorage.usuarioNome,
      tipo: localStorage.usuarioTipo,
      modal: false,
      procurar: "",
      cabecalho: [
        {
          text: "Nome",
          align: "left",
          value: "nome",
          sortable: false
        },
        {
          text: "Matrícula",
          align: "left",
          value: "matricula",
          sortable: false
        },
        {
          text: "Email",
          align: "left",
          value: "email",
          sortable: false
        },
        {
          text: "Tipo",
          align: "left",
          value: "tipo",
          sortable: false
        },
        {
          text: "Ação",
          align: "end",
          value: "acao",
          sortable: false
        }
      ],
      usuarios: [],
      novoUsuario: {
        nome: "",
        matricula: "",
        email: "",
        tipo: "Bolsista",
        senha: "",
        senha2: ""
      },
      categorias: ["Bolsista", "Nutricionista"]
    };
  },
  created() {
    this.inicializar();
  },
  methods: {
    inicializar() {
      Vue.axios.get("user").then(response => {
        this.usuarios = response.data.filter(user => user.tipo !== "admin");
      });
      Vue.axios.get("categoria").then(response => {
        this.qtdCategorias = response.data.length;
      });
      Vue.axios.get("fornecedor").then(response => {
        this.qtdFornecedores = response.data.length;
      });
      Vue.axios.get("produto").then(response => {
        this.qtdProdutos = response.data.length;
      });
      Vue.axios.get("pedido").then(response => {
        this.qtdPedidos = response.data.length;
      });
    },
    cancelar() {
      this.modal = false;
      this.novoUsuario.nome = "";
      this.novoUsuario.matricula = "";
      this.novoUsuario.email = "";
      this.novoUsuario.tipo = "Bolsista";
      this.novoUsuario.senha = "";
      this.novoUsuario.senha2 = "";
    },
    salvar() {
      Usuario.cadastrar(
        this.novoUsuario,
        () => {
          alert("Cadastro realizado com sucesso");
          this.inicializar();
        },
        () => {
          alert("Falha ao cadastrar usuário");
        }
      );
      this.cancelar();
    },
    abrirModal() {
      this.modal = true;
    },
    deletarUsuario(item) {
      if (confirm(`Deseja deletar o usuário ${item.nome}?`)) {
        const id = item.id;
        Usuario.deletar(
          id,
          () => {
            alert("Usuário deletado com sucesso");
            this.inicializar();
          },
          () => {
            alert("Falha");
          }
        );
      }
    }
  },
  computed: {
    habilitarBotaoCadastro() {
      if (!this.novoUsuario.nome.length > 0) {
        return true;
      } else if (!this.novoUsuario.matricula.length > 0) {
        return true;
      } else if (!this.novoUsuario.email.length > 0) {
        return true;
      } else if (!this.novoUsuario.senha.length > 0) {
        return true;
      } else if (!this.novoUsuario.senha2.length > 0) {
        return true;
      } else if (this.novoUsuario.senha !== this.novoUsuario.senha2) {
        return true;
      } else {
        return false;
      }
    }
  }
};
</script>
