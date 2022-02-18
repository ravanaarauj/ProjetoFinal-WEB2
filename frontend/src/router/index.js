import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

const routes = [
  {
    path: '/home',
    name: 'home',
    component: () => import(/* webpackChunkName: "home" */ '../views/Home.vue'),
  },
  {
    path: '/categorias',
    name: 'categorias',
    component: () => import(/* webpackChunkName: "categorias" */ '../views/Categorias.vue'),
  },
  {
    path: '/produtos',
    name: 'produtos',
    component: () => import(/* webpackChunkName: "produtos" */ '../views/Produtos.vue'),
  },
  {
    path: '/fornecedores',
    name: 'fornecedores',
    component: () => import(/* webpackChunkName: "fornecedores" */ '../views/Fornecedores.vue'),
  },
  {
    path: '/pedidos',
    name: 'pedidos',
    component: () => import(/* webpackChunkName: "pedidos" */ '../views/Pedidos.vue'),
  },
  {
    path: '/',
    name: 'login',
    component: () => import(/* webpackChunkName: "login" */ '../views/Login.vue'),
  },
];

const router = new VueRouter({
  routes,
});

router.beforeEach((to, from, next) => {
  if (!localStorage.token && to.name !== 'login') {
    next({ name: 'login' });
  } else {
    next();
  }
});

export default router;
