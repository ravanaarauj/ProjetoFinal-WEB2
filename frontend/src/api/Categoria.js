import Vue from 'vue';

export default {
  cadastrar (novaCategoria, success, error) {
    Vue.axios.post('categoria', { nome: novaCategoria.nome }).then((response) => {
      if (Math.floor(response.status / 100) == 2) {
        if (success) success(response.data);
      }
    }).catch((err) => {
      if (error) error(err);
    });
  },
  deletar (id, success, error) {
    Vue.axios.delete(`categoria/${id}`).then((response) => {
      if (Math.floor(response.status / 100) == 2) {
        if (success) success(response.data);
      }
    }).catch((err) => {
      if (error) error(err);
    });
  },
  atualizar (novaCategoria, success, error) {
    Vue.axios.put(`categoria/${novaCategoria.id}`, { nome: novaCategoria.nome }).then((response) => {
      if (Math.floor(response.status / 100) == 2) {
        if (success) success(response.data);
      }
    }).catch((err) => {
      if (error) error(err);
    });
  },
};
