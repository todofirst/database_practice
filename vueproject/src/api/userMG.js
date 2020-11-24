import axios from '@/api/axioBase'
import {formReq} from './axioFun'

export const login = (data) => { return formReq("/login", data) };
export const logout = () => {return axios.get('/logout').then(res => res.data)}


