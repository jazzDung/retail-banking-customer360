import {RETRIEVE_CUSTOMERS, FETCH_CUSTOMERS_FAILURE } from '../actions/types'

const initialState = {
  customers: [],
  error: null,
};

function customerReducer(state  = initialState, action) {
    const { type } = action;

    switch (type) {
        case RETRIEVE_CUSTOMERS:
          return {
            ...state,
            customers: action.payload,
            error: null,
          };
    
          case FETCH_CUSTOMERS_FAILURE:
            return {
              ...state,
              error: action.payload,
            };

        default:
          return state;
      }
}

export default customerReducer;