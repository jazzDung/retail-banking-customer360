import http from "../http-common";
import _ from 'lodash'

class CustomerService {
  get({queries, orderBy , pageSize, page}) {
    var params = `page_size=${pageSize}&page=${page}&is_paginate=true`
    
    if(queries && !_.isEmpty(queries)){
      params += `&query=${JSON.stringify(queries)}`;
    }

    if(orderBy&& !_.isEmpty(orderBy) && !_.isEmpty(orderBy.columns)){
      params += `&order_by=${JSON.stringify(orderBy)}`;
    }
    
    console.log("call to customers: ", params)
    return http.get(`/customers?${params}` );
  }

  getById(id) {
    console.log("call to customers ", id)

    return http.get(`/customers/${id}`);
  }
}

export default new CustomerService();