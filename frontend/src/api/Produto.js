import Vue from 'vue';

export default {
  cadastrar (novoProduto, success, error) {
    delete novoProduto.id;
    Vue.axios.post('produto', { ...novoProduto }).then((response) => {
      if (Math.floor(response.status / 100) == 2) {
        if (success) success(response.data);
      }
    }).catch((err) => {
      if (error) error(err);
    });
  },
  deletar (id, success, error) {
    Vue.axios.delete(`produto/${id}`).then((response) => {
      if (Math.floor(response.status / 100) == 2) {
        if (success) success(response.data);
      }
    }).catch((err) => {
      if (error) error(err);
    });
  },
  atualizar (novoProduto, success, error) {
    Vue.axios.put(`produto/${novoProduto.id}`, { ...novoProduto }).then((response) => {
      if (Math.floor(response.status / 100) == 2) {
        if (success) success(response.data);
      }
    }).catch((err) => {
      if (error) error(err);
    });
  },
};
