import axios from 'axios';
import qs from 'qs';

// 全局配置
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

// 拦截器
axios.interceptors.request.use((config) => {
  // Toast.loading();

  config.headers['X-Version'] = '1.0';
  return config;
}, err => Promise.reject(err));



// 拦截器
axios.interceptors.response.use(({ data }) => {
  return data;
});

/**
 * 提交表单
 */
const postJson = (url, data = {}) => {
  return axios.post(url, data, {
    headers: {
      'Content-Type': 'application/json;charset=UTF-8',
    },
  });
};

/**
 * export
 */
export {
  postJson
};

// default, install
export default {
  install(Vue) {
    Vue.http = {postJson};
    Vue.prototype.$http = Vue.http;
  },
};
