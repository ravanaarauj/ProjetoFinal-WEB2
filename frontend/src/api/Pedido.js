import Vue from 'vue';

export default {
  cadastrar (novoPedido, success, error) {
    Vue.axios.post('pedido', { ...novoPedido }).then((response) => {
      if (Math.floor(response.status / 100) == 2) {
        if (success) success(response.data);
      }
    }).catch((err) => {
      if (error) error(err);
    });
  },
  deletar (id, success, error) {
    Vue.axios.delete(`pedido/${id}`).then((response) => {
      if (Math.floor(response.status / 100) == 2) {
        if (success) success(response.data);
      }
    }).catch((err) => {
      if (error) error(err);
    });
  },
};
