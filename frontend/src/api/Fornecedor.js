import Vue from 'vue';

export default {
  cadastrar (novoFornecedor, success, error) {
    delete novoFornecedor.id;
    Vue.axios.post('fornecedor', { ...novoFornecedor }).then((response) => {
      if (Math.floor(response.status / 100) == 2) {
        if (success) success(response.data);
      }
    }).catch((err) => {
      if (error) error(err);
    });
  },
  deletar (id, success, error) {
    Vue.axios.delete(`fornecedor/${id}`).then((response) => {
      if (Math.floor(response.status / 100) == 2) {
        if (success) success(response.data);
      }
    }).catch((err) => {
      if (error) error(err);
    });
  },
  atualizar (novoFornecedor, success, error) {
    const id = novoFornecedor.id;
    delete novoFornecedor.id;
    Vue.axios.put(`fornecedor/${id}`, { ...novoFornecedor }).then((response) => {
      if (Math.floor(response.status / 100) == 2) {
        if (success) success(response.data);
      }
    }).catch((err) => {
      if (error) error(err);
    });
  },
};
