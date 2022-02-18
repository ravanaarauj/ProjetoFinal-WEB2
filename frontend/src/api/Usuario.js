import Vue from 'vue';

export default {
  cadastrar (novoUsuario, success, error) {
    Vue.axios.post('user', { ...novoUsuario }).then((response) => {
      if (Math.floor(response.status / 100) == 2) {
        if (success) success(response.data);
      }
    }).catch((err) => {
      if (error) error(err);
    });
  },
  autenticar (usuario, success, error) {
    Vue.axios.post('user/login', {
      ...usuario
    }).then((response) => {
      if (response.status == 200) {
        if ((typeof response.data.token != 'undefined') && (response.data.token != '')) {
          localStorage.token = response.data.token;
          localStorage.setItem("usuarioNome", response.data.usuario.nome);
          localStorage.setItem("usuarioTipo", response.data.usuario.tipo);
          localStorage.setItem("usuarioMatricula", response.data.usuario.matricula);
          localStorage.setItem("usuarioID", Number(response.data.usuario.id));
          if (success) success(response.data);
        }
      } else error();
    }).catch(() => {
      if (error) error();
    });
  },
  deletar (id, success, error) {
    Vue.axios.delete(`user/${id}`).then((response) => {
      if (Math.floor(response.status / 100) == 2) {
        // localStorage.token = response.data.accessToken;
        if (success) success(response.data);
      }
    }).catch((err) => {
      if (error) error(err);
    });
  },
};
