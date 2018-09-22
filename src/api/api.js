import axios from 'axios';
import { postJson } from '@/plugins/http';
const base = '/api';

export const requestLogin = params => { 
  return postJson(`http://localhost:8080/user/login`, params);
};

export const getUserList = params => { return axios.get(`${base}/user/list`, { params: params }); };

export const getCateListPage = params => { 
  return postJson(`${base}/cate/findAll`, { params: params }); 
};

export const removeCate = params => { 
  return postJson(`${base}/cate/deleteById`,params);
};

export const batchRemoveUser = params => { return axios.get(`${base}/user/batchremove`, { params: params }); };

export const editUser = params => { return axios.get(`${base}/user/edit`, { params: params }); };

export const addUser = params => { return axios.get(`${base}/user/add`, { params: params }); };