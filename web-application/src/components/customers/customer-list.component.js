import React, { Component, useState, useEffect } from "react";
import { connect } from "react-redux";
import { retrieveCustomers } from '../../actions/customerSlice'
import CustomerTable from "./customer-table.component";
import JsonViewer from "./JsonViewer.component";
import { Tabs, Tab, Form, Button  } from 'react-bootstrap';
import Select from 'react-select';
import _ from 'lodash';

function CustomersList(props) {
  const operations = [
    'exact', 'notExact', 'greaterThan', 'lessThan', 'greaterThanOrEqual', 'lessThanOrEqual', 'in', 'contains'
  ];

  const fields = [
    'customer_id', 'identity_id', 'last_name', 'first_name', 'full_name', 'date_of_birth',
    'age', 'gender', 'address', 'status', 'hometown', 'phone', 'email', 'customer_register_date',
    'customer_type', 'loan_count', 'origin_principal', 'total_interest', 'paid_interest',
    'unpaid_loan_amount', 'unpaid_loan_count', 'savings_count', 'origin_deposit_amount', 'matured_deposit_amount'
  ];

  const sortTypes = [
    { value: 'asc', label: 'asc' },
    { value: 'desc', label: 'desc' }
  ];

  const [state, setState] = useState({
    propertyName: '',
    compareType: '',
    propertyValue: '',
    queries: {},
    orderByColumns: [],
    sortType: '',
    orderBy: {
      columns: [],
      type: 'asc'
    },
    is_paginate: true,
    pageSize: 20,
    page: 1
  });

  useEffect(() => {
    props.retrieveCustomers({
      queries: state.queries,
      orderBy: state.orderBy,
      is_paginate: state.is_paginate,
      pageSize: state.pageSize,
      page: state.page
    });
  }, [props]);

  const refreshData = () => {
    setState({
      ...state,
      propertyName: '',
      compareType: '',
      propertyValue: '',
      queries: {},
      orderByColumns: [],
      sortType: '',
      orderBy: {
        columns: [],
        type: 'asc'
      },
      is_paginate: true,
      pageSize: 20,
      page: 1
    });
  };

  const onChangeProperty = (event) => {
    setState({
      ...state,
      [event.target.name]: event.target.value
    });
  };

  const onAddButtonClicked = () => {
    const { propertyName, compareType, propertyValue } = state;

    setState({
      ...state,
      propertyName: '',
      compareType: '',
      propertyValue: '',
      queries: {
        ...state.queries,
        [propertyName]: {
          [compareType]: propertyValue
        }
      }
    });
  };

  const handleColumnsChange = (selected) => {
    setState({
      ...state,
      orderByColumns: selected,
      orderBy: {
        ...state.orderBy,
        columns: selected.map(item => item.value)
      }
    });
  };

  const handleSortTypeChange = (selected) => {
    setState({
      ...state,
      sortType: selected,
      orderBy: {
        ...state.orderBy,
        type: selected.value
      }
    });
  };

  const getFieldOptions = () => {
    return fields.map(field => ({ value: field, label: field }));
  };

  const onSearchButtonClicked = ()=>{
    props.retrieveCustomers({
      queries: state.queries,
      orderBy: state.orderBy,
      is_paginate: state.is_paginate,
      pageSize: state.pageSize,
      page: state.page
    });
  }

  return (
    <div className="flex flex-col h-full">
      <header className="z-10 items-start px-9 pt-9 pb-2.5 text-2xl font-bold text-black max-md:px-5 max-md:max-w-full">
        Customer screen
      </header>

      <div className="shrink-0 h-0.5 bg-black bg-opacity-10 w-[95%] self-center" />

      <div className="self-center mt-3.5 w-[95%]">
        <section className="row mb-2">
          <div className="col-8 h-full">
            <div className="card shadow p-3 bg-white rounded" style={{ height: '375px' }}>
              <div className="card-body overflow-auto" style={{ maxHeight: '380px', background: '#f5f5f5' }}>
                <span>http://k8s-apiserve-apiserve-03159dafcc-74596ca9fbb60af8.elb.us-east-1.amazonaws.com/api/customers?page_size={state.pageSize}&page={state.page}&is_paginate=true</span>
                {state.queries && !_.isEmpty(state.queries) && <span>&query=</span>}
                {state.queries && !_.isEmpty(state.queries) && <JsonViewer data={state.queries} />}
                {state.orderBy.columns && !_.isEmpty(state.orderBy.columns) && <span>&order_by=</span>}
                {state.orderBy.columns && !_.isEmpty(state.orderBy.columns) && <JsonViewer data={state.orderBy} />}
              </div>
              <Button type="button" className="btn btn-primary pull-right mt-2" style={{ width: '75px' }} onClick={onSearchButtonClicked}>Search</Button>
            </div>
          </div>

          <div className="col-4">
            <div className="card shadow p-3 bg-white rounded" style={{ height: '375px' }}>
              <div className="card-body">
                <Tabs defaultActiveKey="query" id="uncontrolled-tab-example">
                  <Tab eventKey="query" title="Query">
                    <form className="form-group mt-3">
                      <div className="form-group mb-2">
                        <label htmlFor="propertyName">Property name</label>
                        <select className="form-select" value={state.propertyName} name='propertyName' onChange={onChangeProperty}>
                          <option disabled value="">--Choose an option--</option>
                          {fields.map(field => <option key={field} value={field}>{field}</option>)}
                        </select>
                      </div>
                      <div className="form-group mb-2">
                        <label htmlFor="compareType">Compare type</label>
                        <select className="form-select" value={state.compareType} name='compareType' onChange={onChangeProperty}>
                          <option disabled value="">--Choose an option--</option>
                          {operations.map(op => <option key={op} value={op}>{op}</option>)}
                        </select>
                      </div>
                      <div className="form-group mb-3">
                        <label htmlFor="propertyValue">Value</label>
                        <input className="form-control" type="text"  value={state.propertyValue} name='propertyValue' onChange={onChangeProperty} />
                      </div>
                      <div className="d-flex justify-content-between">
                        <button type="button" className="btn btn-primary" onClick={onAddButtonClicked}>Add</button>
                        <button type="button" className="btn btn-outline-secondary" onClick={refreshData}>Reset</button>
                      </div>
                    </form>
                  </Tab>
                  <Tab eventKey="sort" title="Sort">
                    <form className="form-group mt-3">
                      <Form.Group>
                        <Form.Label>Columns</Form.Label>
                        <Select
                          isMulti
                          name="columns"
                          options={getFieldOptions()}
                          className="basic-multi-select"
                          classNamePrefix="select"
                          value={state.orderByColumns}
                          onChange={handleColumnsChange}
                        />
                      </Form.Group>
                      <Form.Group>
                        <Form.Label>Sort type</Form.Label>
                        <Select
                          name="columns"
                          options={sortTypes}
                          className="basic-select"
                          classNamePrefix="select"
                          value={state.sortType}
                          onChange={handleSortTypeChange}
                        />
                      </Form.Group>
                      <div className="d-flex justify-content-between mt-5">
                        <button type="button" className="btn btn-outline-secondary" onClick={refreshData}>Reset</button>
                      </div>
                    </form>
                  </Tab>
                  <Tab eventKey="paging" title="Paging">
                    <form className="form-group mt-3">
                        <Form.Group>
                          <Form.Label>Page size</Form.Label>
                          <input className="form-control" type="text" 
                            name="pageSize"
                            value={state.pageSize}
                            onChange={onChangeProperty}
                          />
                        </Form.Group>
                        <Form.Group>
                          <Form.Label>Page</Form.Label>
                          <input className="form-control" type="text" 
                            name="page"
                            value={state.page}
                            onChange={onChangeProperty}
                          />
                        </Form.Group>
                        <div className="d-flex justify-content-between mt-5">
                          <button type="button" className="btn btn-outline-secondary" onClick={refreshData}>Reset</button>
                        </div>
                      </form>
                  </Tab>
                </Tabs>
              </div>
            </div>
          </div>
        </section>
      </div>

      <div className="self-center mt-3.5 w-[95%] h-100">
        <CustomerTable customers={props.customers} />
      </div>
    </div>
  );
}

const mapStateToProps = (state) => ({
  customers: state.customers.customers,
});

export default connect(mapStateToProps, { retrieveCustomers })(CustomersList);